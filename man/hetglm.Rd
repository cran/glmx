\name{hetglm}
\alias{hetglm}
\alias{hetglm.fit}

\alias{print.hetglm}
\alias{summary.hetglm}
\alias{print.summary.hetglm}
\alias{predict.hetglm}
\alias{coef.hetglm}
\alias{vcov.hetglm}
\alias{bread.hetglm}
\alias{estfun.hetglm}
\alias{coeftest.hetglm}
\alias{logLik.hetglm}
\alias{terms.hetglm}
\alias{model.frame.hetglm}
\alias{model.matrix.hetglm}
\alias{residuals.hetglm}
\alias{update.hetglm}

\title{Heteroscedastic Binary Response GLMs}

\description{
  Fit heteroscedastic binary response models via maximum likelihood.
}

\usage{
hetglm(formula, data, subset, na.action, weights, offset,
  family = binomial(link = "probit"),
  link.scale = c("log", "sqrt", "identity"),
  control = hetglm.control(\dots),
  model = TRUE, y = TRUE, x = FALSE, \dots)

hetglm.fit(x, y, z = NULL, weights = NULL, offset = NULL,
  family = binomial(), link.scale = "log", control = hetglm.control())
}

\arguments{
  \item{formula}{symbolic description of the model (of type \code{y ~ x}
    or \code{y ~ x | z}; for details see below).}
  \item{data, subset, na.action}{arguments controlling formula processing
    via \code{\link[stats]{model.frame}}.}
  \item{weights}{optional numeric vector of case weights.}
  \item{offset}{optional numeric vector(s) with an a priori known component to be
    included in the linear predictor(s).}
  \item{family}{family object (including the link function of the mean model).}
  \item{link.scale}{character specification of the link function in
    the latent scale model.}
  \item{control}{a list of control arguments specified via
    \code{\link{hetglm.control}}.}
  \item{model, y, x}{logicals. If \code{TRUE} the corresponding components
    of the fit (model frame, response, model matrix) are returned.
    For \code{hetglm.fit}, \code{x} should be a numeric regressor matrix
    and \code{y} should be the numeric response vector (with values in (0,1)).}
  \item{z}{numeric matrix. Regressor matrix for the precision model, defaulting
    to an intercept only.}
  \item{\dots}{arguments passed to \code{\link{hetglm.control}}.}
}

\details{
  A set of standard extractor functions for fitted model objects is available for
  objects of class \code{"hetglm"}, including methods to the generic functions
  \code{\link[base]{print}}, \code{\link[base]{summary}}, \code{\link[stats]{coef}}, 
  \code{\link[stats]{vcov}}, \code{\link[stats]{logLik}}, \code{\link[stats]{residuals}}, 
  \code{\link[stats]{predict}}, \code{\link[stats]{terms}}, \code{\link[stats]{update}},
  \code{\link[stats]{model.frame}}, \code{\link[stats]{model.matrix}},
  \code{\link[sandwich]{estfun}} and \code{\link[sandwich]{bread}} (from the \pkg{sandwich} package), and
  \code{\link[lmtest]{coeftest}} (from the \pkg{lmtest} package).  
}

\value{
  \code{hetglm} returns an object of class \code{"hetglm"}, i.e., a list with components as follows.
  \code{hetglm.fit} returns an unclassed list with components up to \code{converged}.
  \item{coefficients}{a list with elements \code{"mean"} and \code{"scale"}
    containing the coefficients from the respective models,}
  \item{residuals}{a vector of raw residuals (observed - fitted),}
  \item{fitted.values}{a vector of fitted means,}
  \item{optim}{output from the \code{optim} call for maximizing the log-likelihood,}
  \item{method}{the method argument passed to the \code{optim} call,}
  \item{control}{the control arguments passed to the \code{optim} call,}
  \item{start}{the starting values for the parameters passed to the \code{optim} call,}
  \item{weights}{the weights used (if any),}
  \item{offset}{the list of offset vectors used (if any),}
  \item{n}{number of observations,}
  \item{nobs}{number of observations with non-zero weights,}
  \item{df.null}{residual degrees of freedom in the homoscedastic null model,}
  \item{df.residual}{residual degrees of freedom in the fitted model,}
  \item{loglik}{log-likelihood of the fitted model,}
  \item{loglik.null}{log-likelihood of the homoscedastic null model,}
  \item{dispersion}{estimate of the dispersion parameter (if any),}
  \item{vcov}{covariance matrix of all parameters in the model,}
  \item{family}{the family object used,}
  \item{link}{a list with elements \code{"mean"} and \code{"scale"}
    containing the link objects for the respective models,}
  \item{converged}{logical indicating successful convergence of \code{optim},}
  \item{call}{the original function call,}
  \item{formula}{the original formula,}  
  \item{terms}{a list with elements \code{"mean"}, \code{"scale"} and
    \code{"full"} containing the terms objects for the respective models,}
  \item{levels}{a list with elements \code{"mean"}, \code{"scale"} and
    \code{"full"} containing the levels of the categorical regressors,}
  \item{contrasts}{a list with elements \code{"mean"} and \code{"scale"}
    containing the contrasts corresponding to \code{levels} from the
    respective models,}
  \item{model}{the full model frame (if \code{model = TRUE}),}
  \item{y}{the response vector (if \code{y = TRUE}),}
  \item{x}{a list with elements \code{"mean"} and \code{"scale"}
    containing the model matrices from the respective models
    (if \code{x = TRUE}).}
}

\seealso{\code{\link[Formula]{Formula}}}

\examples{
## Generate artifical binary data from a latent
## heteroscedastic normally distributed variable
set.seed(48)
n <- 200
x <- rnorm(n)
ystar <- 1 + x +  rnorm(n, sd = exp(x))
y  <- factor(ystar > 0) 

## visualization
par(mfrow = c(1, 2))
plot(ystar ~ x, main = "latent")
abline(h = 0, lty = 2)
plot(y ~ x, main = "observed")

## model fitting of homoscedastic model (m0a/m0b)
## and heteroscedastic model (m)
m0a <- glm(y ~ x, family = binomial(link = "probit"))
m0b <- hetglm(y ~ x | 1)
m <- hetglm(y ~ x)

## coefficient estimates
cbind(heteroscedastic = coef(m),
  homoscedastic = c(coef(m0a), 0))

## summary of correct heteroscedastic model
summary(m)



## Generate artificial binary data with a single binary regressor
## driving the heteroscedasticity in a model with two regressors
set.seed(48)
n <- 200
x <- rnorm(n)
z <- rnorm(n)
a <- factor(sample(1:2, n, replace = TRUE))
ystar <- 1 + c(0, 1)[a] + x + z + rnorm(n, sd = c(1, 2)[a])
y  <- factor(ystar > 0) 

## fit "true" heteroscedastic model
m1 <- hetglm(y ~ a + x + z | a)

## fit interaction model
m2 <- hetglm(y ~ a/(x + z) | 1)

## although not obvious at first sight, the two models are
## nested. m1 is a restricted version of m2 where the following
## holds: a1:x/a2:x == a1:z/a2:z
if(require("lmtest")) lrtest(m1, m2)

## both ratios are == 2 in the data generating process
c(x = coef(m2)[3]/coef(m2)[4], z = coef(m2)[5]/coef(m2)[6])



if(require("AER")) {

## Labor force participation example from Greene
## (5th edition: Table 21.3, p. 682)
## (6th edition: Table 23.4, p. 790)

## data (including transformations)
data("PSID1976", package = "AER")
PSID1976$kids <- with(PSID1976, factor((youngkids + oldkids) > 0,
  levels = c(FALSE, TRUE), labels = c("no", "yes")))
PSID1976$fincome <- PSID1976$fincome/10000

## Standard probit model via glm()
lfp0a <- glm(participation ~ age + I(age^2) + fincome + education + kids,
  data = PSID1976, family = binomial(link = "probit"))

## Standard probit model via hetglm() with constant scale
lfp0b <- hetglm(participation ~ age + I(age^2) + fincome + education + kids | 1,
  data = PSID1976)

## Probit model with varying scale
lfp1 <- hetglm(participation ~ age + I(age^2) + fincome + education + kids | kids + fincome,
  data = PSID1976)

## Likelihood ratio and Wald test
lrtest(lfp0b, lfp1)
waldtest(lfp0b, lfp1)

## confusion matrices
table(true = PSID1976$participation,
  predicted = fitted(lfp0b) <= 0.5)
table(true = PSID1976$participation,
  predicted = fitted(lfp1) <= 0.5)



## Adapted (and somewhat artificial) example to illustrate that
## certain models with heteroscedastic scale can equivalently
## be interpreted as homoscedastic scale models with interaction
## effects.

## probit model with main effects and heteroscedastic scale in two groups
m <- hetglm(participation ~ kids + fincome | kids, data = PSID1976)

## probit model with interaction effects and homoscedastic scale
p <- glm(participation ~ kids * fincome, data = PSID1976,
   family = binomial(link = "probit"))

## both likelihoods are equivalent
logLik(m)
logLik(p)

## intercept/slope for the kids=="no" group
coef(m)[c(1, 3)]
coef(p)[c(1, 3)]

## intercept/slope for the kids=="yes" group
c(sum(coef(m)[1:2]), coef(m)[3]) / exp(coef(m)[4])
coef(p)[c(1, 3)] + coef(p)[c(2, 4)]

## Wald tests for the heteroscedasticity effect in m and the 
## interaction effect in p are very similar
coeftest(m)[4,]
coeftest(p)[4,]

## corresponding likelihood ratio tests are equivalent
## (due to the invariance of the MLE)
m0 <- hetglm(participation ~ kids + fincome | 1, data = PSID1976)
p0 <- glm(participation ~ kids + fincome, data = PSID1976,
  family = binomial(link = "probit"))
lrtest(m0, m)
lrtest(p0, p)

}
}

\keyword{regression}
