.onAttach <- function(libname, pkgname) {
  tick <- stats::rbinom(n = 1, size = 1, prob = 0.3)
  if (tick == 1) {
    packageStartupMessage("This is {comorbidity} version 1.0.3.")
    packageStartupMessage("A lot has changed since the pre-1.0.0 release on CRAN, please check-out breaking changes here:")
    packageStartupMessage("-> https://ellessenne.github.io/comorbidity/articles/C-changes.html")
  }
}
