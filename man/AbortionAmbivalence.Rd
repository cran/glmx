\name{AbortionAmbivalence}
\alias{AbortionAmbivalence}
\title{American Ambivalence towards Abortion Policy}

\description{
Data about attitudes towards abortion policy in the US. 
Cross-section data from the US General Social Survey 1982 with
oversample of African American respondents.
}

\usage{data("AbortionAmbivalence")}

\format{
A data frame containing 1860 observations on 20 variables.
\describe{
  \item{health}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if the woman's own health is seriously endangered by
    the pregnancy?}
  \item{rape}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if she became pregnant as a result of rape?}
  \item{defect}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if there is a strong chance of serious defect in the baby?}
  \item{poor}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if the family has a very low income and cannot afford any
    more children?}
  \item{nomore}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if she is married and does not want any more children?}
  \item{single}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if she is not married and does not want to marry the man?}
  \item{any}{factor. Answer to the question: Please tell me whether
    or not you think it should be possible for a pregnant woman to obtain
    a legal abortion if the woman wants it for reason?}
  \item{ethnicity}{factor indicating ethnicity.
    Is the individual African-American (\code{"afam"}) or not (\code{"other"})?}
  \item{gender}{factor indicating gender.}
  \item{religion}{factor indicating religious preference (\code{"catholic"} or
    \code{"other"}).}
  \item{religiousness}{Religious intensity as coded by Alvarez and Brehm (1995).}
  \item{religiousness2}{Religious intensity in an alternative coding suggested by
    Altman and McDonald (1995).}
  \item{church}{Numeric coding of frequency of attending church.}
  \item{erameans}{factor. Answer to the question: Do you understand what the
    Equal Rights Amendment (ERA) means?}
  \item{erasupport}{Intensity of support for ERA.}
  \item{pros}{Number of arguments in favor of abortion named by the subject.}
  \item{cons}{Number of arguments against abortion named by the subject.}
  \item{importance}{Numeric coding of subjective importance of abortion issue.}
  \item{information}{Numeric coding of self-assessment of information on abortion issue
    available to the subject.}
  \item{firmness}{Numeric coding of subjective firmness of opinion on abortion.}
}
}

\details{
The data were prepared and analyzed by Alvarez and Brehm (1995). A detailed
discussion of the variables is provided in their Appendix A and the model
is developed in their Section 3.

The data were reanalyzed by Altman and McDonald (2003) with focus on numerical
accuracy and by Keele and Park (2006) with focus on interpretability.
}

\source{
Online supplements to Altman and McDonald (2003).

\doi{10.1093/pan/mpg016}
}

\references{
Altman M, McDonald MP (2003). \dQuote{Replication with Attention to Numerical Accuracy.}
\emph{Political Analysis}, \bold{11}, 302--307.

Alvarez RM, Brehm J (1995). \dQuote{American Ambivalence towards Abortion Policy: Development
of a Heteroskedastic Probit Model of Competing Values.} \emph{American Journal of Political
Science}, \bold{39}(4), 1055--1082.

Keele LJ, Park DK (2006). \emph{Ambivalent about Ambivalence: A Re-Examination of Heteroskedastic Probit Models.}
Unpublished manuscript.
}

\seealso{\code{\link{hetglm}}}

\examples{
data("AbortionAmbivalence")

## first model for mother's health
ab_health <- hetglm(
  health ~ ethnicity + gender + religion + religiousness + church + erameans + erasupport |
  pros * cons + importance + information + firmness, data = AbortionAmbivalence)
summary(ab_health)

## corresponding model with analytical gradients but numerical Hessian
ab_health2 <- update(ab_health, method = "BFGS", hessian = TRUE)
summary(ab_health2)

## Alvarez and Brehm (1995), Table 1, p. 1069
## (see also Altman and McDonald, 2003, Supplement, Tables 4-10)
tab1 <- sapply(names(AbortionAmbivalence)[1:7], function(x) {
  f <- as.formula(paste(x,
    "~ ethnicity + gender + religion + religiousness + church + erameans + erasupport",
    "| pros * cons + importance + information + firmness"))
  f0 <- as.formula(paste(x, "~ 1"))
  m <- hetglm(f, data = AbortionAmbivalence)
  m0 <- hetglm(f0, data = model.frame(m))
  c(Percent_yes = as.vector(100 * prop.table(table(AbortionAmbivalence[[x]]))["yes"]),
    coef(m)[c(1:10, 14, 11:13)],
    Heteroscedasticity = as.vector(summary(m)$lrtest[1]),
    N = nobs(m),
    Goodness_of_fit = 2 * as.vector(logLik(m) - logLik(m0))
  )
})
round(tab1, digits = 2)


if(require("AER")) {
## compare Wald tests with different types of standard errors
coeftest(ab_health)
coeftest(ab_health2)
coeftest(ab_health,  vcov = sandwich)
coeftest(ab_health2, vcov = sandwich)
coeftest(ab_health,  vcov = vcovOPG)
coeftest(ab_health2, vcov = vcovOPG)

ab_health_tstat <- cbind(
  "A-Info"     = coeftest(ab_health)[,3],
  "N-Info"     = coeftest(ab_health2)[,3],
  "A-Sandwich" = coeftest(ab_health,  vcov = sandwich)[,3],
  "N-Sandwich" = coeftest(ab_health2, vcov = sandwich)[,3],
  "A-OPG"      = coeftest(ab_health,  vcov = vcovOPG)[,3],
  "N-OPG"      = coeftest(ab_health2, vcov = vcovOPG)[,3]
)
round(ab_health_tstat, digits = 3)
}
}

\keyword{datasets}
