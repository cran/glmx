\name{glmx}
\alias{glmx}
\alias{glmx.fit}

\alias{coef.glmx}
\alias{formula.glmx}
\alias{logLik.glmx}
\alias{nobs.glmx}
\alias{print.glmx}
\alias{summary.glmx}
\alias{vcov.glmx}

\title{Generalized Linear Models with Extra Parameters}

\description{
  Estimation of generalized linear models with extra parameters,
  e.g., parametric links, or families with additional parameters
  (such as negative binomial).
}

\usage{
glmx(formula, data, subset, na.action, weights, offset,
  family = negative.binomial, xlink = "log", control = glmx.control(...),
  model = TRUE, y = TRUE, x = FALSE, \dots)

glmx.fit(x, y, weights = NULL, offset = NULL,
  family = negative.binomial, xlink = "log", control = glmx.control())
}

\arguments{
  \item{formula}{symbolic description of the model.}
  \item{data, subset, na.action}{arguments controlling formula processing
    via \code{\link[stats]{model.frame}}.}
  \item{weights}{optional numeric vector of case weights.}
  \item{offset}{optional numeric vector(s) with an a priori known component to be
    included in the linear predictor.}
  \item{family}{function that returns a \code{"family"} object, i.e.,
    \code{family(x)} needs to be a \code{"family"} object when
    \code{x} is the numeric vector of extra parameters (by default assumed
    to be 1-dimensional).}
  \item{xlink}{link object or a character that can be passed to \code{\link[stats]{make.link}}.
    It should link the extra parameters to real parameters.}
  \item{control}{a list of control arguments as returned by \code{\link{glmx.control}}.}
  \item{model, y, x}{logicals. If \code{TRUE} the corresponding components
    of the fit (model frame, response, model matrix) are returned.
    For \code{glmx.fit}, \code{x} should be a numeric regressor matrix
    and \code{y} should be the response vector.}
  \item{\dots}{control arguments.}
}

\details{
  The function \code{glmx} is a convenience interface that estimates generalized
  linear models (GLMs) with extra parameters. Examples would be binary response models
  with parametric link functions or count regression using a negative binomial family
  (which has one additional parameter).
  
  Hence, \code{glmx} needs a \code{family} argument which is a family-generating function
  depending on one numeric argument for the extra parameters. Then, either profile-likelihood
  methods can be used for optimizing the extra parameters or all parameters can be
  optimized jointly.
  
  If the generated \code{family} contains a list element \code{loglik.extra} for the
  derivative of the log-likelihood with respect to the extra parameters (i.e., score/gradient
  contributions), then this is used in the optimization process. This should be a
  \code{function(y, mu, extra)} depending on the observed response \code{y}, the estimated
  mean \code{mu}, and the \code{extra} parameters.
}
  
\value{
  \code{glmx} returns an object of class \code{"glmx"}, i.e., a list with components as follows.
  \code{glmx.fit} returns an unclassed list with components up to \code{converged}.
  \item{coefficients}{a list with elements \code{"glm"} and \code{"extra"}
    containing the coefficients from the respective models,}
  \item{residuals}{a vector of deviance residuals,}
  \item{fitted.values}{a vector of fitted means,}
  \item{optim}{list of \code{optim} outputs for maximizing the \code{"profile"}
    and \code{"full"} log-likelihood, respectively,}
  \item{weights}{the weights used (if any),}
  \item{offset}{the list of offset vectors used (if any),}
  \item{n}{number of observations,}
  \item{nobs}{number of observations with non-zero weights,}
  \item{df}{number of estimated parameters,}
  \item{loglik}{log-likelihood of the fitted model,}
  \item{dispersion}{estimate of the dispersion parameter (if any),}
  \item{vcov}{covariance matrix of all parameters in the model,}
  \item{family}{a list with elements \code{"glm"} and \code{"extra"} where the former
    contains the \code{"family"} object at the optimal extra parameters and
    the latter the family-generating function,}
  \item{xlink}{the link object for the extra parameters,}
  \item{control}{control options used,}
  \item{converged}{logical indicating successful convergence of \code{optim},}
  \item{call}{the original function call,}
  \item{formula}{the formula,}  
  \item{terms}{the terms object for the model,}
  \item{levels}{the levels of the categorical regressors,}
  \item{contrasts}{the contrasts corresponding to \code{levels},}
  \item{model}{the full model frame (if \code{model = TRUE}),}
  \item{y}{the response vector (if \code{y = TRUE}),}
  \item{x}{the model matrix (if \code{x = TRUE}).}
}

\seealso{\code{\link{glmx.control}}, \code{\link{hetglm}}}

\examples{
## artificial data from geometric regression
set.seed(1)
d <- data.frame(x = runif(200, -1, 1))
d$y <- rnbinom(200, mu = exp(0 + 3 * d$x), size = 1)

### negative binomial regression ###

## negative binomial regression via glmx
if(require("MASS")) {
m_nb1 <- glmx(y ~ x, data = d,
  family = negative.binomial, xlink = "log", xstart = 0)
summary(m_nb1)

## negative binomial regression via MASS::glm.nb
m_nb2 <- glm.nb(y ~ x, data = d)
summary(m_nb2)

## comparison
if(require("lmtest")) {
logLik(m_nb1)
logLik(m_nb2)
coeftest(m_nb1)
coeftest(m_nb2)
exp(coef(m_nb1, model = "extra"))
m_nb2$theta
exp(coef(m_nb1, model = "extra")) * sqrt(vcov(m_nb1, model = "extra"))
m_nb2$SE.theta
}}

## if the score (or gradient) contribution of the extra parameters
## is supplied, then estimation can be speeded up:
negbin <- function(theta) {
  fam <- negative.binomial(theta)
  fam$loglik.extra <- function(y, mu, theta) digamma(y + theta) - digamma(theta) +
    log(theta) + 1 - log(mu + theta) - (y + theta)/(mu + theta)
  fam
}
m_nb3 <- glmx(y ~ x, data = d,
  family = negbin, xlink = "log", xstart = 0, profile = FALSE)
all.equal(coef(m_nb1), coef(m_nb3))


### censored negative binomial hurdle regression (0 vs. > 0) ###

## negative binomial zero hurdle part via glmx
nbbin <- function(theta) binomial(link = nblogit(theta))
m_hnb1 <- glmx(factor(y > 0) ~ x, data = d,
  family = nbbin, xlink = "log", xstart = 0)
summary(m_hnb1)

## negative binomial hurdle regression via pscl::hurdle
## (see only zero hurdle part)
if(require("pscl")) {
m_hnb2 <- hurdle(y ~ x, data = d, dist = "negbin", zero.dist = "negbin")
summary(m_hnb2)
}
}

\keyword{regression}
