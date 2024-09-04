# glmx 0.2-1

* Updated example reference output for CRAN checks.


# glmx 0.2-0

* Improved handling of dispersion in GLM families based on the new
  `family$dispersion` infrastructure in R 4.3.0 (contributed by
  Martyn Plummer).


# glmx 0.1-3

* Small documentation improvements.


# glmx 0.1-2

* Improved family initialization in case of binomial (rather than binary)
  models.

* Unified spelling to "heteroscedastic" rather than "heteroskedastic".

* Added some `tests` as well as reference output for the examples.


# glmx 0.1-1

* Added `predict()` method for `glmx` objects.

* Small improvements in `NAMESPACE`.


# glmx 0.1-0

* First CRAN release of `glmx`. However, all functions are
  still under development and both interfaces and internals
  might change in future releases.
  
* The main functions are `hetglm()` for heteroscedastic GLMs
  (in particular heteroscedastic probit etc.), `glmx()` for GLMs
  with extra parameters (such as parametric links), and a collection
  of parametric links for binary regressions.
