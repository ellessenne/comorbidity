.onAttach <- function(libname, pkgname) {
  if (rbinom(n = 1, size = 1, prob = 0.5) == 1) {
    packageStartupMessage("This is {comorbidity} version 1.0.0.")
    packageStartupMessage("A lot has changed since the last release on CRAN, please check-out breaking changes here:")
    packageStartupMessage("-> https://ellessenne.github.io/comorbidity/articles/C-changes.html")
    packageStartupMessage("Sorry to bother you! This message will disappear in future updates.")
  }
}
