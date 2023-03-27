## regressors
set.seed(6020)
d <- data.frame(
  x = runif(500, -1, 1),
  z = runif(500, -1, 1)
)

## rational predictor
d$eta <- (0 + 1 * d$x) / exp(1 * d$z)

## Gaussian, binary, and Poisson response
d$ynum <- rnorm(500, mean = d$eta, sd = 1)
d$ybin <- factor(rbinom(500, prob = plogis(d$eta), size = 1))
d$ypoi <- rpois(500, lambda = exp(d$eta))

## rational GLMs
library("glmx")
mnum <- hetglm(ynum ~ x | z, data = d, family = gaussian)
mbin <- hetglm(ybin ~ x | z, data = d, family = binomial)
mpoi <- hetglm(ypoi ~ x | z, data = d, family = poisson)

## comparison of coefficients
options(digits = 4)
cbind(
  "True" = c(0, 1, 1),
  "Gaussian" = coef(mnum),
  "Binary" = coef(mbin),
  "Poisson" = coef(mpoi)
)

## confidence intervals
confint(mnum)
confint(mbin)
confint(mpoi)

## full summaries
print(summary(mnum), show.residuals = TRUE)
print(summary(mbin), show.residuals = TRUE)
print(summary(mpoi), show.residuals = TRUE)
