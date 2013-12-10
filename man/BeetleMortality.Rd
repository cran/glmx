\name{BeetleMortality}
\alias{BeetleMortality}

\title{Bliss (1935) Beetle Mortality Data}

\description{
Mortality of adult flour beetle after five hours' exposure to gaseous carbon disulphide.
}

\usage{data("BeetleMortality")}

\format{
A data frame containing 8 observations on 3 variables.
\describe{
  \item{dose}{numeric. \eqn{\log_{10}} dose.}
  \item{died}{integer. Number killed.}
  \item{n}{integer. Number exposed.}
}
}
	
\details{
The data originates from Bliss (1935) and has been reanalyzed frequently.
}

\source{
Bliss CI (1935). \dQuote{The Calculation of the Dosage-Mortality Curve.}
  \emph{Annals of Applied Biology}, \bold{22}, 134--167.
}

\references{
  Aranda-Ordaz F (1981). \dQuote{On Two Families of Transformations to Additivity for Binary Response Data.}
    \emph{Biometrika}, \bold{68}, 357--363.

  Hauck W (1990). \dQuote{Choice of Scale and Asymmetric Logistic Models.}
    \emph{Biometrical Journal}, \bold{32}, 79--86 

  Prentice RL (1976). \dQuote{A Generalization of the Probit and Logit Methods for Dose Response Curves.}
    \emph{Biometrics}, \bold{38}, 761--768. 

  Pregibon D (1980). \dQuote{Goodness of Link Tests for Generalized Linear Models.}
    \emph{Journal of the Royal Statistical Society C}, \bold{29}, 15--23. 
}

\examples{
## data
data("BeetleMortality", package = "glmx")

## various standard binary response models
m <- lapply(c("logit", "probit", "cloglog"), function(type)
  glm(cbind(died, n - died) ~ dose, data = BeetleMortality, family = binomial(link = type)))

## visualization
plot(I(died/n) ~ dose, data = BeetleMortality)
lines(fitted(m[[1]]) ~ dose, data = BeetleMortality, col = 2)
lines(fitted(m[[2]]) ~ dose, data = BeetleMortality, col = 3)
lines(fitted(m[[3]]) ~ dose, data = BeetleMortality, col = 4)
}

\keyword{datasets}
