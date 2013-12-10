.ab_to_scale <- function(a, b)
  (qgl(3/4, c(0, 1, a - b, a + b)) -  qgl(1/4, c(0, 1, a - b, a + b)))/2.197224

.ab_to_lambda <- function(a, b)
  c(0, 1, a - b, a + b)

qpregibon <- function(p, a = 0, b = 0, lower.tail = TRUE, log.p = FALSE)
{
  stopifnot(require("gld"))
  if(log.p) p <- exp(p)
  if(!lower.tail) p <- 1 - p
  qgl(p, .ab_to_lambda(a, b))/.ab_to_scale(a, b)
}

ppregibon <- function(q, a = 0, b = 0, lower.tail = TRUE, log.p = FALSE, tol = 1e-12)
{
  stopifnot(require("gld"))
  p <- pgl(q * .ab_to_scale(a, b), .ab_to_lambda(a, b), inverse.eps = tol)
  if(!lower.tail) p <- 1 - p
  if(log.p) p <- log(p)
  return(p)
}

dpregibon <- function(x, a = 0, b = 0, log = FALSE, tol = 1e-12)
{
  stopifnot(require("gld"))
  s <- .ab_to_scale(a, b)
  d <- dgl(x * s, .ab_to_lambda(a, b), inverse.eps = tol) * s
  if(log) log(d) else d
}

rpregibon <- function(n, a = 0, b = 0)
{
  stopifnot(require("gld"))
  qpregibon(runif(n), a = a, b = b)
}
