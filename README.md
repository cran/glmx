# Generalized Linear Models Extended in R

## Overview

The R package [glmx](https://zeileis.codeberg.page/glmx/) provides:

* Estimation of generalized linear models with extra parameters via `glmx`,
  e.g., parametric links, or families with additional parameters
  (such as negative binomial).

* Estimation of heteroscedastic binary response models
  via `hetglm` using maximum likelihood.

* Density `dpregibon`, distribution function `ppregibon`, quantile
  function `qpregibon`, and random generation `rpregibon` for the Pregibon
  distribution.

* Various symmetric and asymmetric parametric links for use as
  link function for binomial generalized linear models, including
  `gosset`, `pregibon`, `loglog`, `nblogit`, `angular`, among others.


## Installation

The stable version of `glmx` is available on
[CRAN](https://CRAN.R-project.org/package=glmx):

``` r
install.packages("glmx")
```

The latest development version can be installed from
[R-universe](https://zeileis.R-universe.dev/glmx):

``` r
install.packages("glmx", repos = "https://zeileis.R-universe.dev")
```


## License

The package is available under the
[General Public License version 3](https://www.gnu.org/licenses/gpl-3.0.html)
or [version 2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
