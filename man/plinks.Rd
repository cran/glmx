\name{plinks}
\alias{plinks}

\alias{talpha}
\alias{ao1}
\alias{ao2}
\alias{gj}
\alias{angular}
\alias{foldexp}
\alias{rocke}
\alias{nblogit}
\alias{gosset}
\alias{pregibon}
\alias{loglog}

\concept{parametric link}
\concept{transformation}

\title{Parametric Links for Binomial Generalized Linear Models}
\description{
  Various symmetric and asymmetric parametric links for use as
  link function for binomial generalized linear models.
}

\usage{
  gj(phi, verbose = FALSE)
  foldexp(phi, verbose = FALSE)
  ao1(phi, verbose = FALSE)
  ao2(phi, verbose = FALSE)
  talpha(alpha, verbose = FALSE, splineinv = TRUE,
    eps = 2 * .Machine$double.eps, maxit = 100)
  rocke(shape1, shape2, verbose = FALSE)

  gosset(nu, verbose = FALSE)
  pregibon(a, b)
  nblogit(theta)

  angular(verbose = FALSE)
  loglog()
}

\arguments{
  \item{phi, a, b}{numeric.}
  \item{alpha}{numeric. Parameter in \eqn{[0,2]}{[0,2]}.}
  \item{shape1, shape2, nu, theta}{numeric. Non-negative parameter.}
  \item{splineinv}{logical. Should a (quick and dirty) spline function be used
    for computing the inverse link function? Alternatively, a more precise but somewhat
    slower Newton algorithm is used.}
  \item{eps}{numeric. Desired convergence tolerance for Newton algorithm.}
  \item{maxit}{integer. Maximal number of steps for Newton algorithm.}
  \item{verbose}{logical. Should warnings about numerical issues be printed?}
}

\details{
  Symmetric and asymmetric families parametric link functions are available.
  Many families contain the logit for some value(s) of their parameter(s). 
  
  The symmetric Aranda-Ordaz (1981) transformation
  \deqn{y = \frac{2}{\phi}\frac{x^\phi-(1-x)^\phi}{x^\phi+(1-x)^\phi}}{y = \tfrac{2}{\phi}\tfrac{x^\phi-(1-x)^\phi}{x^\phi+(1-x)^\phi}}
  and the asymmetric Aranda-Ordaz (1981) transformation
  \deqn{y = \log([(1-x)^{-\phi}-1]/\phi)}{y = \log([(1-x)^{-\phi}-1]/\phi)}
  both contain the logit for \eqn{\phi = 0}{\phi = 0} and
  \eqn{\phi = 1}{\phi = 1} respectively, where the latter also includes the
  complementary log-log for \eqn{\phi = 0}{\phi = 0}.
  
  The Pregibon (1980) two parameter family is the link given by
  \deqn{y = \frac{x^{a-b}-1}{a-b}-\frac{(1-x)^{a+b}-1}{a+b}.}
  For \eqn{a = b = 0} it is the logit. For \eqn{b = 0} it is symmetric and
  \eqn{b} controls the skewness; the heavyness of the tails is controlled by
  \eqn{a}. The implementation uses the generalized lambda distribution
  \code{\link{gl}}.
  
  The Guerrero-Johnson (1982) family
  \deqn{y = \frac{1}{\phi}\left(\left[\frac{x}{1-x}\right]^\phi-1\right)}{y = \frac{1}{\phi}\left(\left[\frac{x}{1-x}\right]^\phi-1\right)}
  is symmetric and contains the logit for \eqn{\phi = 0}{\phi = 0}.
  
  The Rocke (1993) family of links is, modulo a linear transformation, the
  cumulative density function of the Beta distribution. If both parameters are
  set to \eqn{0} the logit link is obtained. If both parameters equal
  \eqn{0.5} the Rocke link is, modulo a linear transformation, identical to the
  angular transformation. Also for \code{shape1} = \code{shape2} \eqn{= 1}, the
  identity link is obtained. Note that the family can be used as a one and a two
  parameter family.
  
  The folded exponential family (Piepho, 2003) is symmetric and given by
  \deqn{y = \left\{\begin{array}{ll}
    \frac{\exp(\phi x)-\exp(\phi(1-x))}{2\phi}   &(\phi \neq 0) \\
    x- \frac{1}{2}                 &(\phi = 0)  
    \end{array}\right.}  
  
  The \eqn{t_\alpha} family (Doebler, Holling & Boehning, 2011) given by
  \deqn{y = \alpha\log(x)-(2-\alpha)\log(1-x)}{y = \alpha\log(x)-(2-\alpha)\log(1-x)}
  is asymmetric and contains the logit for \eqn{\phi = 1}{\phi = 1}.
  
  The Gosset family of links is given by the inverse of the cumulative
  distribution function of the t-distribution. The degrees of freedom \eqn{\nu}
  control the heavyness of the tails and is restricted to values \eqn{>0}. For
  \eqn{\nu = 1} the Cauchy link is obtained and for \eqn{\nu \to \infty} the link
  converges to the probit. The implementation builds on \code{\link{qf}} and is
  reliable for \eqn{\nu \geq 0.2}. Liu (2004) reports that the Gosset link
  approximates the logit well for \eqn{\nu = 7}.
  
  Also the (parameterless) angular (arcsine) transformation
  \eqn{y = \arcsin(\sqrt{x})}{y = \arcsin(\sqrt{x})} is available as a link
  function.
}
  
\value{
  An object of the class \code{link-glm}, see the documentation of \code{\link{make.link}}.
}

\references{
  Aranda-Ordaz F (1981). \dQuote{On Two Families of Transformations to Additivity for Binary Response Data.}
    \emph{Biometrika}, \bold{68}, 357--363.

  Doebler P, Holling H, Boehning D (2012). \dQuote{A Mixed Model Approach to Meta-Analysis of Diagnostic Studies with Binary Test Outcome.} 
    \emph{Psychological Methods}, \bold{17}(3), 418--436.

  Guerrero V, Johnson R (1982). \dQuote{Use of the Box-Cox Transformation with Binary Response Models.}
    \emph{Biometrika}, \bold{69}, 309--314.

  Koenker R (2006). \dQuote{Parametric Links for Binary Response.}
    \emph{R News}, \bold{6}(4), 32--34.

  Koenker R, Yoon J (2009). \dQuote{Parametric Links for Binary Choice Models: A Fisherian-Bayesian Colloquy.}
    \emph{Journal of Econometrics}, \bold{152}, 120--130.

  Liu C (2004). \dQuote{Robit Regression: A Simple Robust Alternative to Logistic and Probit Regression.}
    In Gelman A, Meng X-L (Eds.),
    \emph{Applied Bayesian Modeling and Causal Inference from Incomplete-Data Perspectives}, Chapter 21,
    pp. 227--238. John Wiley \& Sons.

  Piepho H (2003). The Folded Exponential Transformation for Proportions.
    \emph{Journal of the Royal Statistical Society D}, \bold{52}, 575--589.
  
  Pregibon D (1980). \dQuote{Goodness of Link Tests for Generalized Linear Models.}
    \emph{Journal of the Royal Statistical Society C}, \bold{29}, 15--23. 
  
  Rocke DM (1993). \dQuote{On the Beta Transformation Family.}
    \emph{Technometrics}, \bold{35}, 73--81.
}

\seealso{\code{\link{make.link}}, \code{\link{family}}, \code{\link{glmx}}, \code{\link{WECO}}}

\keyword{regression}
