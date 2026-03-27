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

Because treatment is randomly assigned, inference can be based directly on the assignment mechanism rather than on large-sample approximations. This is particularly useful given the small sample size.

#### 4.2.1 Standard randomization inference

We implement standard (Fisher) randomization inference using the difference-in-differences estimator:

$$
\hat{\delta}_{DD} = (\bar{Y}_{11} - \bar{Y}_{01}) - (\bar{Y}_{10} - \bar{Y}_{00}).
$$

Procedure:

1. Compute the observed statistic $\hat{\delta}_{DD}^{obs}$  
2. Keep outcomes $Y_i$ fixed  
3. Reassign respondents to the four $(R_i, S_i)$ cells, preserving group sizes  
4. For each reassignment $b = 1,\dots,B$, recompute:

$$
\hat{\delta}_{DD}^{(b)} = (\bar{Y}_{11}^{(b)} - \bar{Y}_{01}^{(b)}) - (\bar{Y}_{10}^{(b)} - \bar{Y}_{00}^{(b)}).
$$

5. Compute the p-value:

$$
\hat{p} = \frac{1 + \sum_{b=1}^{B} \mathbf{1}\left(|\hat{\delta}_{DD}^{(b)}| \geq |\hat{\delta}_{DD}^{obs}|\right)}{B+1}.
$$

This provides an exact test under the sharp null:

$$
H_0^{sharp}: Y_i(1,1) = Y_i(0,1) = Y_i(1,0) = Y_i(0,0) \quad \forall i,
$$

i.e. romanticization has no effect for any respondent.

#### 4.2.2 Limitation

The parameter of interest is the interaction effect:

$$
\delta = \mathbb{E}[Y_i(1,1) - Y_i(0,1)] - \mathbb{E}[Y_i(1,0) - Y_i(0,0)],
$$

with null hypothesis:

$$
H_0: \delta = 0.
$$

This is a **weak null**, which allows non-zero treatment effects within each scenario as long as they are equal on average. The sharp null underlying standard randomization inference is therefore too restrictive and does not match the research question.

---

### 4.3 Randomization inference for weak nulls

To address this issue, we follow Wu & Ding (2020) and use a studentized statistic within the randomization framework.

#### 4.3.1 Statistic

Let $\hat{\theta}$ denote the estimated interaction effect. We use the studentized statistic:

$$
T^{obs} = \frac{\hat{\theta}}{\widehat{se}(\hat{\theta})}.
$$

#### 4.3.2 Procedure

1. Compute $T^{obs}$ from the observed data  
2. Reassign respondents to treatment cells according to the original design  
3. For each reassignment $b = 1,\dots,B$, compute:

$$
T^{(b)} = \frac{\hat{\theta}^{(b)}}{\widehat{se}(\hat{\theta}^{(b)})}
$$

4. Compute the p-value:

$$
\hat{p} = \frac{1 + \sum_{b=1}^{B} \mathbf{1}\left(|T^{(b)}| \geq |T^{obs}|\right)}{B+1}.
$$

#### 4.3.3 Why this works

Under a weak null, the distribution of $\hat{\delta}_{DD}$ depends on unknown features such as treatment effect heterogeneity and unequal variances across groups, making standard randomization inference invalid.

Studentization transforms the estimator into a signal-to-noise ratio. The resulting statistic is approximately **pivotal**, meaning its distribution depends much less on unknown parameters.

Wu and Ding show that, although the statistic is not perfectly pivotal in the potential outcomes framework, its distribution is **stochastically dominated by a pivotal distribution**. As a result:

- the test remains **exact under the sharp null**, and  
- it is **asymptotically conservative under the weak null** $H_0: \delta = 0$  

Thus, it controls type I error even in the presence of heterogeneous treatment effects.

#### 4.3.4 Interpretation

Standard randomization inference tests a strong null of no treatment effects at all, while the Wu and Ding approach targets the weaker and more relevant null of no difference in average treatment effects across scenarios. In our setting, this provides a more appropriate design-based test of the heterogeneous treatment effect.

### 4.3 A nonparametric test

Bootstrap ? 
