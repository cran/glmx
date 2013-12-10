\name{WECO}
\alias{WECO}

\title{Productivity and Quit Behavior of Western Electric Workers}

\description{
Partially artificial data about quit behavior of Western Electric workers.
(Western Electric was the manufacturing arm of the AT&T corporation during
its glory days as a monopolist in the U.S. telephone industry.)
}

\usage{data("WECO")}

\format{
A data frame containing 683 observations on 7 variables.
\describe{
  \item{output}{productivity in first six months.}
  \item{sex}{factor indicating gender.}
  \item{dex}{score on a preemployment dexterity exam.}
  \item{lex}{years of education.}
  \item{kwit}{factor indicating whether the worker quit in the first six months.}
  \item{tenure}{duration of employment (see details).}
  \item{censored}{logical. Is the duration censored?}
}
}

\details{
The explanatory variables in this example are taken from the study of Klein et
al. (1991), but the response variable was altered long ago to improve the
didactic impact of the model as a class exercise. To this end, quit dates for
each individual were generated according to a log Weibull proportional hazard
model.
}

\source{
Online supplements to Koenker (2006) and Koenker and Yoon (2009).

\url{http://www.econ.uiuc.edu/~roger/research/links/links.html}
}

\references{
Klein R, Spady R, Weiss A (1991). \dQuote{Factors Affecting the Output and Quit Propensities of Production Workers.}
  \emph{The Review of Economic Studies}, \bold{58}(5), 929--953.

Koenker R (2006). \dQuote{Parametric Links for Binary Response.}
  \emph{R News}, \bold{6}(4), 32--34.

Koenker R, Yoon J (2009). \dQuote{Parametric Links for Binary Choice Models: A Fisherian-Bayesian Colloquy.}
  \emph{Journal of Econometrics}, \bold{152}, 120--130.
}

\seealso{\code{\link{plinks}}}

\examples{
\donttest{
## WECO data
data("WECO", package = "glmx")
f <- kwit ~ sex + dex + poly(lex, 2, raw = TRUE)
## (raw = FALSE would be numerically more stable)

## Gosset model
gossbin <- function(nu) binomial(link = gosset(nu))
m1 <- glmx(f, data = WECO,
  family = gossbin, xstart = 0, xlink = "log")

## Pregibon model
pregibin <- function(shape) binomial(link = pregibon(shape[1], shape[2]))
m2 <- glmx(f, data = WECO,
  family = pregibin, xstart = c(0, 0), xlink = "identity")

## Probit/logit/cauchit models
m3 <- lapply(c("probit", "logit", "cauchit"), function(nam)
  glm(f, data = WECO, family = binomial(link = nam)))

## Probit/cauchit vs. Gosset
if(require("lmtest")) {
lrtest(m3[[1]], m1)
lrtest(m3[[3]], m1)

## Logit vs. Pregibon
lrtest(m3[[2]], m2)
}

## Table 1
tab1 <- sapply(c(m3, list(m1)), function(obj)
  c(head(coef(obj), 5), AIC(obj)))
colnames(tab1) <- c("Probit", "Logit", "Cauchit", "Gosset")
rownames(tab1)[4:6] <- c("lex", "lex^2", "AIC")
tab1 <- round(t(tab1), digits = 3)
tab1

## Figure 4
plot(fitted(m3[[1]]), fitted(m1),
  xlim = c(0, 1), ylim = c(0, 1),
  xlab = "Estimated Probit Probabilities",
  ylab = "Estimated Gosset Probabilities")
abline(0, 1)
}
}

\keyword{datasets}
