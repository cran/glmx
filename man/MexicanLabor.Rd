\name{MexicanLabor}
\alias{MexicanLabor}

\title{Mexican Women's Labor-Force Participation}

\description{
Data from the National Survey of Household Income and Expenditures for 1977,
Secretaria de Programacion y Presupuesto, Mexico.
}

\usage{data("MexicanLabor")}

\format{
A data frame containing 16 observations on 6 variables.
\describe{
  \item{total}{integer. Number of women older than 12 years.}
  \item{laborforce}{integer. Number of women in labor force.}
  \item{locality}{factor with levels \code{"rural"}/\code{"urban"}.}
  \item{age}{factor with levels \code{"<= 24"} and \code{"> 24"} (in years).}
  \item{income}{factor with levels \code{"low"}/\code{"high"}
    (household income less or more than $2626.8).}
  \item{schooling}{factor with levels \code{"primary"} (primary school or less)
    and \code{"further"} (more than primary school).}
}
}

\details{
The data were first analyzed by Guerrero and Johnson (1982) as an example of a
highly asymmetric data set, i.e., the observed proportions are rather low.
}

\source{
  Guerrero V, Johnson R (1982). \dQuote{Use of the Box-Cox Transformation with Binary Response Models.}
    \emph{Biometrika}, \bold{69}, 309--314.
}

\examples{
## data
data("MexicanLabor", package = "glmx")

## visualizations
plot(I(laborforce/total) ~ interaction(income, age), data = MexicanLabor)
plot(I(laborforce/total) ~ interaction(schooling, locality), data = MexicanLabor)

## simple logit model
m <- glm(cbind(laborforce, total - laborforce) ~ ., data = MexicanLabor, family = binomial)
m
}

\keyword{datasets}
