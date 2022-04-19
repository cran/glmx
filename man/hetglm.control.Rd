\name{hetglm.control}
\alias{hetglm.control}

\title{Control Parameters for Heteroscedastic Binary Response GLMs}
\description{
  Various parameters that control fitting of heteroscedastic binary response models
  using \code{\link{hetglm}}.
}

\usage{
hetglm.control(method = "nlminb", maxit = 1000,
  hessian = FALSE, trace = FALSE, start = NULL, \dots)
}

\arguments{
  \item{method}{characters string specifying either that \code{\link[stats]{nlminb}}
    is used for optimization or the \code{method} argument passed to
    \code{\link[stats]{optim}} (typically, \code{"BFGS"} or \code{"L-BFGS-B"}).}
  \item{maxit}{integer specifying the maximal number of iterations in the optimization.}
  \item{hessian}{logical. Should the numerical Hessian matrix from the \code{optim} output
    be used for estimation of the covariance matrix? The default (and only option for
    \code{nlminb}) is to use the analytical expected information rather than the numerical Hessian.}
  \item{trace}{logical or integer controlling whether tracing information on  
    the progress of the optimization should be produced?}
  \item{start}{an optional vector with starting values for all parameters.}
  \item{\dots}{arguments passed to the optimizer.}
}

\details{
  All parameters in \code{\link{hetglm}} are estimated by maximum likelihood
  using either \code{\link[stats]{nlminb}} (default) or \code{\link[stats]{optim}}
  with analytical gradients and (by default) analytical expected information.
  Further control options can be set in \code{\link{hetglm.control}}, most of which
  are simply passed on to the corresponding optimizer.

  Starting values can be supplied via \code{start} or estimated by
  \code{\link[stats:glm]{glm.fit}}, using the homoscedastic model.
  Covariances are derived analytically by default. Alternatively, the numerical
  Hessian matrix returned by \code{optim} can be employed, in case this is used
  for the optimization itself.
}

\value{
  A list with the processed specified arguments.
}

\seealso{\code{\link{hetglm}}}

\keyword{regression}
