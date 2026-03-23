## 1. The statistical estimand of interest

Let:

- $R_i \in \{0,1\}$ denote whether the article shown to respondent $i$ is romanticized, where $R_i = 1$ means romanticized language is used and $R_i = 0$ means neutral language is used
- $S_i \in \{0,1\}$ denote the scenario, where $S_i = 1$ is the femicide scenario (man kills wife) and $S_i = 0$ is the male-victim scenario (woman kills husband)
- $Y_i(r,s)$ denote respondent $i$'s potential outcome, for example a responsibility score, if exposed to an article with romanticization status $r$ and scenario $s$

The observed outcome is:

$$
Y_i = Y_i(R_i,S_i),
$$

under the usual SUTVA assumption.

It is useful to first define the romanticization effect within each scenario:

$$
\tau_F = \mathbb{E}[Y_i(1,1) - Y_i(0,1)]
$$

for the femicide scenario, and

$$
\tau_M = \mathbb{E}[Y_i(1,0) - Y_i(0,0)]
$$

for the male-victim scenario.

These two conditional effects can then be used to define the estimand of interest.

### Difference in the Effect Across Scenarios

The second research question asks whether the effect of romanticization differs depending on whether the victim is a woman or a man. This is an interaction estimand:

$$
\delta = \tau_F - \tau_M
= \mathbb{E}[Y_i(1,1) - Y_i(0,1)] - \mathbb{E}[Y_i(1,0) - Y_i(0,0)].
$$

This estimand measures whether romanticization has a stronger or weaker effect in the femicide scenario than in the male-victim scenario.

If higher values of $Y_i$ mean greater attributed responsibility, then a more negative treatment effect means that romanticization reduces perceived responsibility more strongly. In that case, $\delta \neq 0$ indicates heterogeneous treatment effects across the two scenarios.

## 2. Identification (internal validity)

These effects can be identified by randomly assigning respondents to the four cells of the `2 x 2` design. Randomization implies that treatment assignment is independent of the potential outcomes:

$$
(R_i,S_i) \perp \{Y_i(r,s): r \in \{0,1\}, s \in \{0,1\}\}.
$$

As a result, the expected outcome in each treatment cell uniquely identifies the corresponding expected potential outcome:

$$
\mathbb{E}[Y_i \mid R_i = r, S_i = s] = \mathbb{E}[Y_i(r,s)].
$$

Therefore, the two scenario-specific treatment effects are identified from differences in observed cell expectations:

$$
\tau_F = \mathbb{E}[Y_i \mid R_i = 1, S_i = 1] - \mathbb{E}[Y_i \mid R_i = 0, S_i = 1],
$$

$$
\tau_M = \mathbb{E}[Y_i \mid R_i = 1, S_i = 0] - \mathbb{E}[Y_i \mid R_i = 0, S_i = 0].
$$

The estimand of interest is then also identified:

$$
\delta = \tau_F - \tau_M.
$$

## 3. Estimation

Let $\bar{Y}_{rs}$ denote the sample mean outcome in cell $(R_i = r, S_i = s)$, and let $n_{rs}$ denote the number of respondents in that cell.

### 3.1 Double difference in empirical means

The most direct estimator uses the empirical mean in each of the four cells. The two scenario-specific treatment effects are estimated by:

$$
\hat{\tau}_F = \bar{Y}_{11} - \bar{Y}_{01},
$$

$$
\hat{\tau}_M = \bar{Y}_{10} - \bar{Y}_{00}.
$$

The interaction estimand is then estimated by the difference-in-differences of these two sample contrasts:

$$
\hat{\delta}_{DD} = \hat{\tau}_F - \hat{\tau}_M
= (\bar{Y}_{11} - \bar{Y}_{01}) - (\bar{Y}_{10} - \bar{Y}_{00}).
$$


### 3.2 Regression with an interaction term

The same estimand can be estimated by estimating the following saturated linear model by OLS

$$
Y_i = \alpha + \beta R_i + \gamma S_i + \theta (R_i \times S_i) + u_i.
$$

Under the notation used above:
- $\alpha$ is the mean outcome in the male-victim control group
- $\beta$ estimates the treatment effect in the male-victim scenario, so $\beta = \hat{\tau}_M$
- $\beta + \theta$ estimates the treatment effect in the femicide scenario, so $\beta + \theta = \hat{\tau}_F$
- $\theta$ estimates the interaction effect, so $\theta = \hat{\delta}$

In this `2 x 2` design, the coefficient on the interaction term is exactly the difference-in-differences estimator:

$$
\hat{\theta} = \hat{\delta}_{DD}.
$$

If the regression includes an intercept, the two main effects, and their interaction, and if no extra controls are added, then the regression estimator and the double-difference in empirical means are numerically identical. The regression formulation is nevertheless useful because it makes it easy to add pre-treatment covariates to improve precision. Because treatment is randomized, such controls are not needed for identification, but they can reduce residual variance and therefore improve precision.

In this context, whether the gain is large depends on whether the controls strongly predict the responsibility outcome. If they do not, the gain in precision may be small. If they do, the gain can be meaningful, especially in a moderate sample. The key restriction is that only pre-treatment covariates should be used.

## 4. Inference and hypothesis testing

The empirical question is whether the causal effect is statistically different from zero. For the two scenario-specific effects, this means testing:

$$
H_0^F: \tau_F = 0
\qquad \text{against} \qquad
H_1^F: \tau_F \neq 0,
$$

and

$$
H_0^M: \tau_M = 0
\qquad \text{against} \qquad
H_1^M: \tau_M \neq 0.
$$

For the heterogeneous effect, the null hypothesis is:

$$
H_0^\delta: \delta = 0
\qquad \text{against} \qquad
H_1^\delta: \delta \neq 0.
$$

The same inferential methods can be applied to each of these effects. Below, the discussion focuses on the interaction effect $\delta$, but the logic is the same for $\tau_F$ and $\tau_M$.

### 4.1 Standard inference

The standard approach is to use the large-sample distribution of the estimator. Under i.i.d. sampling and standard regularity conditions,

$$
\sqrt{n}(\hat{\delta} - \delta) \overset{d}{\longrightarrow} \mathcal{N}(0,V_\delta).
$$

This suggests using a Wald-type statistic:

$$
t = \frac{\hat{\delta}}{\widehat{se}(\hat{\delta})},
$$

and rejecting the null when $|t|$ is sufficiently large.

If the estimator is obtained from the saturated OLS regression above, one can test the null using the coefficient on the interaction term. Under stronger classical assumptions, such as a correctly specified linear model, homoskedastic errors, and normal disturbances, the usual OLS $t$-statistic has a Student distribution in finite samples. In large samples, however, the relevant approximation is asymptotic normality. 

For the double-difference estimator, a natural plug-in variance estimator is:

$$
\mathrm{Var}(\hat{\delta})
= \frac{s_{11}^2}{n_{11}} + \frac{s_{01}^2}{n_{01}} + \frac{s_{10}^2}{n_{10}} + \frac{s_{00}^2}{n_{00}},
$$

where $s_{rs}^2$ is the sample variance in cell $(r,s)$.

### 4.2 Randomization inference

- Sharp null is very restrictive in this context since we expect an effect in the first differences.
- Possible approach: Wu and Ding (2020)

### 4.3 A nonparametric test

Bootstrap ? 
