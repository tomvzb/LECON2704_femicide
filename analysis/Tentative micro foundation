## 1. A microfounded theoretical framework

To clarify the hypothesis, it is useful to distinguish between the true responsibility attached to the act and the responsibility eventually reported by respondents.

Let $\theta$ denote the true but unobserved responsibility of the perpetrator in the case described by the article. Higher values of $\theta$ mean greater responsibility. Respondent $i$ does not observe $\theta$ directly. Instead, she starts from a prior belief, which may itself depend on the scenario $s \in \{F,M\}$:

$$
\theta \sim \mathcal{N}(\mu_{is}, \sigma_{0,is}^2).
$$

The neutral article provides a baseline factual signal:

$$
x = \theta + \varepsilon_x,
\qquad
\varepsilon_x \sim \mathcal{N}(0,\sigma_x^2).
$$

When the article is romanticized, the respondent also receives an additional contextual signal:

$$
c = \theta + \varepsilon_c,
\qquad
\varepsilon_c \sim \mathcal{N}(0,\sigma_c^2).
$$

We do not impose a sign restriction on this second signal. It may reduce perceived responsibility if the extra context makes the act look more understandable, but it could also increase perceived responsibility if it highlights obsession, manipulation, or premeditation. In that sense, romanticization contains an information or context channel whose sign is an empirical question.

Let $m_i(r,s)$ denote respondent $i$'s posterior mean belief about true responsibility after processing the informational content of the article, with

$$
m_i(0,s) = \mathbb{E}[\theta \mid x, s]
\qquad\text{and}\qquad
m_i(1,s) = \mathbb{E}[\theta \mid x, c, s].
$$

Under normal signals, $m_i(r,s)$ is a precision-weighted average of the prior, the factual signal, and, when $r=1$, the extra contextual signal.

Romanticization may also operate through a norm channel. For exposition, normalize the internal responsibility scale so that higher values mean more blame and $0$ is a neutral reference point. Let $n_{is}(r)$ denote the social meaning attached to blaming the perpetrator after observing article style $r$ in scenario $s$. This term is positive when the social cue pushes toward harsher blame and negative when it pushes toward greater leniency.

Assume respondent $i$ chooses a reported responsibility score $y_i$ to maximize:

$$
U_i(y) = -\frac{1}{2}(y - m_i(r,s))^2 + \lambda_i d_i n_{is}(r) y,
$$

where $\lambda_i \geq 0$ measures sensitivity to social meaning and $d_i \in \{+1,-1\}$ captures the respondent's orientation toward the perceived norm:

- $d_i = +1$: respondent tends to conform to the perceived norm
- $d_i = -1$: respondent tends to push against it and affirm opposition

The optimal report is then:

$$
y_i^*(r,s) = m_i(r,s) + \lambda_i d_i n_{is}(r).
$$

This gives a simple decomposition of the treatment effect within scenario $s$:

$$
\tau_s = \mathbb{E}[y_i^*(1,s) - y_i^*(0,s)]
= \underbrace{\mathbb{E}[m_i(1,s) - m_i(0,s)]}_{\text{context or information channel}}
+ \underbrace{\mathbb{E}[\lambda_i d_i (n_{is}(1) - n_{is}(0))]}_{\text{norm channel}}.
$$

This decomposition helps clarify the hypothesis. Romanticization can matter because it adds information, because it changes what respondents perceive to be socially acceptable, or because it does both. Differences between femicide and male-victim cases can therefore arise from three sources:

- the additional context may be interpreted differently across scenarios
- the norm cue induced by romanticization may have a different sign or strength across scenarios
- the share of conformist and oppositional respondents may differ across scenarios

### Suggestions to endogenize the bias term

The main theoretical choice is how to model $n_{is}(1) - n_{is}(0)$, rather than taking it as a primitive reduced-form parameter. Here are several plausible microfoundations.

#### 1. Bayesian updating about social norms

Romanticization can be modeled as a noisy signal about an unobserved social norm $N_s$, for instance the degree to which society tolerates exculpatory narratives in scenario $s$. Respondents start from a prior belief $p_{is} = \Pr(N_s = 1)$ and update after observing the article style. The norm term $n_{is}(r)$ is then an increasing function of that posterior belief.

This directly captures the mechanism: romanticization signals that society is more conservative, or more tolerant of leniency, than the respondent previously thought. The effect can differ across femicide and male-victim cases because the same wording may be more surprising in one setting than in the other.

#### 2. Norm salience rather than norm learning

An alternative is that romanticization does not reveal new information about society, but simply makes an existing norm more salient. Formally, one can write:

$$
n_{is}(1) = \rho_{is}\bar{n}_s,
\qquad
n_{is}(0) = 0,
$$

where $\bar{n}_s$ is a pre-existing scenario-specific norm and $\rho_{is}$ measures how strongly romanticization activates it for respondent $i$. This is a reminder mechanism rather than a learning mechanism.

#### 3. Inference from editorial choice

Respondents may infer something about society from the fact that the journalist or outlet chose a romanticized framing. In that version, wording is informative because media outlets choose language partly in response to what their audience will accept. Observing romanticization then shifts beliefs about the distribution of attitudes in society. This makes the norm term endogenous to a sender-receiver problem instead of treating it as a direct taste shock.

#### 4. Endogenous conformity versus backlash

The parameter $d_i$ can itself be endogenized. Suppose respondents care both about social approval and about remaining consistent with their own ideology or moral identity. Then romanticization can push some respondents toward conformity and others toward backlash:

- if approval concerns dominate, respondents move in the direction suggested by the perceived norm
- if identity concerns dominate, respondents move against it to signal opposition

This provides a clean way to model the possibility that romanticization tells some respondents "this is socially accepted," while inducing others to condemn the act more strongly precisely because they reject that signal.

#### 5. Asymmetric legitimacy of compassion

A further possibility is that the relevant norm is not one-dimensional conservatism, but the perceived legitimacy of showing contextual understanding to different types of perpetrators. Respondents may believe that society is more willing to tolerate compassionate framing in one direction than in the other. Then romanticization changes not just the intensity of the norm, but the direction in which empathy is seen as legitimate. This gives a natural way to generate asymmetric effects across femicide and male-victim cases even if respondents have similar baseline ideologies.

Taken together, this framework suggests that the treatment effect is the sum of an ambiguous information effect and a scenario-dependent social-norm effect. A negative effect in one scenario and a zero or positive effect in the other would therefore not necessarily mean that respondents process the facts differently. It could also mean that romanticization changes perceived norms differently across the two settings, or that it triggers different degrees of conformity and backlash.
