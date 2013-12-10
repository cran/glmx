\name{glmx.control}
\alias{glmx.control}

\title{Control Parameters for GLMs with Extra Parameters}
\description{
  Various parameters that control fitting of generalized linear models
  with extra parameters using \code{\link{glmx}}.
}

\usage{
glmx.control(profile = TRUE, nuisance = FALSE,
  start = NULL, xstart = NULL, hessian = TRUE, method = "BFGS", 
  epsilon = 1e-8, maxit = c(500, 25), trace = FALSE,
  reltol = .Machine$double.eps^(1/1.2), \dots)
}

\arguments{
  \item{profile}{logical. Should the extra parameters be optimized via
    profile likelihood (or via the full likelihood of all parameters)?}
  \item{nuisance}{logical. Should the extra parameters be treated as
    nuisance parameters (i.e., suppressed in subsequent output)?}
  \item{start}{an optional vector with starting values for the GLM coefficients.}
  \item{xstart}{an optional vector with starting values for the extra parameter(s).
    Must be supplied if there is more than one extra parameter.}
  \item{hessian}{logical or character. Should the hessian be computed
    to estimate the covariance matrix? If character, \code{hessian} can
    be either \code{"none"}, \code{"optim"} or \code{"numDeriv"}. The
    default is the hessian from \code{\link[stats]{optim}} but alternatively
    \code{\link[numDeriv]{hessian}} from the \pkg{numDeriv} package can be used.}
  \item{method}{characters string specifying the \code{method} argument
    passed to \code{\link[stats]{optim}}.}
  \item{epsilon}{numeric convergance tolerance passed to \code{\link[stats]{glm.control}}.}
  \item{maxit}{integer specifying the \code{maxit} argument (maximal number
    of iterations) passed to \code{\link[stats]{optim}} and \code{\link[stats]{glm.control}}.
    Can also be a vector of length 2.}
  \item{trace}{logical or integer controlling whether tracing information on  
    the progress of the optimization should be produced (passed to
    \code{\link[stats]{optim}}, and \code{\link[stats]{glm.control}}).
    Can also be a vector of length 2.}
  \item{reltol, \dots}{arguments passed to \code{\link[stats]{optim}}.}
}

\details{
  All parameters in \code{\link{glmx}} are estimated by maximum likelihood
  using \code{\link[stats]{optim}} with control options set in \code{\link{glmx.control}}.
  Either the parameters can be found by only optimizing over the extra parameters
  (and then using \code{\link[stats]{glm.fit}} to estimate the GLM coefficients),
  or alternatively all parameters can be optimized simultaneously.
  Covariances are derived numerically using the Hessian matrix returned by
  \code{\link[stats]{optim}}.
}

\value{
  A list with the arguments specified.
}

\seealso{\code{\link{glmx}}}

\keyword{regression}
