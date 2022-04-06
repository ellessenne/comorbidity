.onAttach <- function(libname, pkgname) {
  tick <- stats::rbinom(n = 1, size = 1, prob = 0.4)
  if (tick == 1) {
    packageStartupMessage("This is {comorbidity} version 1.0.2.")
    packageStartupMessage("A lot has changed since the last release on CRAN, please check-out breaking changes here:")
    packageStartupMessage("-> https://ellessenne.github.io/comorbidity/articles/C-changes.html")
  }
}
