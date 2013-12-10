\name{hetglm.control}
\alias{hetglm.control}

\title{Control Parameters for Heteroskedastic Binary Response GLMs}
\description{
  Various parameters that control fitting of heteroskedastic binary response models
  using \code{\link{hetglm}}.
}

\usage{
hetglm.control(method = "nlminb", maxit = 1000,
  hessian = FALSE, trace = FALSE, start = NULL, \dots)
}

\arguments{
  \item{method}{characters string specifying the \code{method} argument
    passed to \code{\link[stats]{optim}}.}
  \item{maxit}{integer specifying the \code{maxit} argument (maximal number
    of iterations) passed to \code{\link[stats]{optim}}.}
  \item{hessian}{logical. Should the numerical Hessian matrix from the \code{optim} output
    be used for estimation of the covariance matrix? Currently, this must not be
    modified.}
  \item{trace}{logical or integer controlling whether tracing information on  
    the progress of the optimization should be produced (passed to \code{\link[stats]{optim}}).}
  \item{start}{an optional vector with starting values for all parameters (including phi).}
  \item{\dots}{arguments passed to \code{\link[stats]{optim}}.}
}

\details{
  All parameters in \code{\link{hetglm}} are estimated by maximum likelihood
  using \code{\link[stats]{optim}} with control options set in \code{\link{hetglm.control}}.
  Most arguments are passed on directly to \code{optim}, only \code{start} controls
  how \code{optim} is called.

  Starting values can be supplied via \code{start} or estimated by
  \code{\link[stats:glm]{glm.fit}}, using the homoskedastic model.
  Covariances are derived numerically using the Hessian matrix returned by
  \code{\link[stats]{optim}}.
}

\value{
  A list with the arguments specified.
}

\seealso{\code{\link{hetglm}}}

\keyword{regression}
