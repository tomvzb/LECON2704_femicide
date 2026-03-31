install.packages(c("dplyr", "ggplot2", "broom", "sandwich", "lmtest", "modelsummary", "rstudioapi"))

library(rstudioapi)
library(modelsummary)
library(dplyr)
library(ggplot2)
library(broom)
library(sandwich)
library(lmtest)
library(car)
library(tidyr)
library(emmeans)
library(modelsummary)
library(knitr)

df <- read.csv(file.choose(), sep=";")

## 1. Clean the data
# 1.1 Create the treatment groups (for plots)
df <- df %>%
  mutate(
    group = case_when(
      Femicide == 0 & Romanticization == 0 ~ "Male - Neutral",
      Femicide == 0 & Romanticization == 1 ~ "Male - Romantic",
      Femicide == 1 & Romanticization == 0 ~ "Female - Neutral",
      Femicide == 1 & Romanticization == 1 ~ "Female - Romantic"
    )
  )

# 1.2 Transform outcomes into numeric variables
df <- df %>%
  mutate(
    Resp = as.numeric(gsub(",", ".", Resp)),
    Donation_psych = as.numeric(gsub(",", ".", Donation_psych)),
    Gap = as.numeric(gsub(",", ".", Gap))
  )

# 1.3 Eliminate the empty cells for each outcome
# For Resp
df_resp <- df %>%
  filter(!is.na(Resp))

# For Donation
df_donation <- df %>%
  filter(!is.na(Donation))

# For Gap
df_gap <- df %>%
  filter(!is.na(Gap))


## 2. Extract results
# 2.1 Run the two models (one for Responsability outcome, one for Donation outcome)
model_resp <- lm(Resp ~ Femicide * Romanticization, data = df_resp)
model_donation <- lm(Donation ~ Femicide * Romanticization, data = df_donation)

# 2.2 Create a function to extract treatment effects (H1) and the interaction effect (H2)

extract_results <- function(model, outcome_name) {
  
  # --- Treatment effects (via emmeans) ---
  eff <- emmeans(model, ~ Romanticization | Femicide)
  contr <- contrast(eff, method = "revpairwise")
  contr_df <- as.data.frame(summary(contr))
  
  treat <- contr_df %>%
    mutate(
      Effect = ifelse(Femicide == 0,
                      "Treatment (Male victim)",
                      "Treatment (Female victim)")
    ) %>%
    select(Effect, estimate, SE, p.value)
  
  # --- Interaction effect (H2) ---
  coefs <- summary(model)$coefficients
  
  inter <- data.frame(
    Effect = "Interaction (H2)",
    estimate = coefs["Femicide:Romanticization", "Estimate"],
    SE = coefs["Femicide:Romanticization", "Std. Error"],
    p.value = coefs["Femicide:Romanticization", "Pr(>|t|)"]
  )
  
  # --- Combine ---
  res <- bind_rows(treat, inter) %>%
    mutate(Outcome = outcome_name)
  
  return(res)
}

# 2.3 Extract the results from the 2 models and display them
res_resp <- extract_results(model_resp, "Responsibility")
res_donation <- extract_results(model_donation, "Donation")

# Bind all results
res_all <- bind_rows(res_resp, res_donation)

# Function to format results
format_results <- function(df) {
  df %>%
    mutate(
      formatted = sprintf("%.3f (SE = %.3f, p = %.3f)",
                          estimate, SE, p.value)
    )
}

res_all <- format_results(res_all)


# Create final table
final_table <- res_all %>%
  select(Effect, Outcome, formatted) %>%
  pivot_wider(
    names_from = Outcome,
    values_from = formatted
  )


modelsummary::datasummary_df(
  final_table,
  title = "Treatment Effects of Romanticization by Victim Type",
  output = "markdown"
)

modelsummary::datasummary_df(
  final_table,
  title = "Treatment Effects of Romanticization by Victim Type",
  output = "latex",
  fmt = 3,
  escape = FALSE,
  tabularray = FALSE  
)

## 3. Randomization inference
# 3.1 Prepare the data
df_ri <- df %>%
  dplyr::filter(!is.na(Resp))

# 3.2 Function to compute DiD
compute_did <- function(data) {
  mean(data$Resp[data$Romanticization == 1 & data$Femicide == 1]) -
    mean(data$Resp[data$Romanticization == 0 & data$Femicide == 1]) -
    (mean(data$Resp[data$Romanticization == 1 & data$Femicide == 0]) -
       mean(data$Resp[data$Romanticization == 0 & data$Femicide == 0]))
}

# 3.3 Compute the observed statistic
delta_obs <- compute_did(df_ri)

# 3.4 Create cell labels
df_ri$cell <- paste(df_ri$Romanticization, df_ri$Femicide)

# 3.5 Randomization procedure
set.seed(123)
B <- 5000

delta_perm <- numeric(B)

cells <- df_ri$cell  # original assignment

for (b in 1:B) {
  
  # Shuffle the FULL treatment assignment
  perm_cells <- sample(cells)
  
  df_perm <- df_ri
  
  # Reconstruct R and S from shuffled cells
  df_perm$Romanticization <- as.numeric(substr(perm_cells, 1, 1))
  df_perm$Femicide <- as.numeric(substr(perm_cells, 3, 3))
  
  # Compute DiD
  delta_perm[b] <- compute_did(df_perm)
}

# 3.6 Compute p-value
p_value <- (1 + sum(abs(delta_perm) >= abs(delta_obs))) / (B + 1)
p_value

# 3.7 Visualize randomization distribution
hist(delta_perm, breaks = 30,
     main = "Randomization Distribution of DiD",
     xlab = "DiD")

abline(v = delta_obs, col = "red", lwd = 2)
