.onAttach <- function(libname, pkgname) {
  tick <- stats::rbinom(n = 1, size = 1, prob = 0.1)
  if (tick == 1) {
    packageStartupMessage(paste0("This is {comorbidity} version ", utils::packageVersion("comorbidity"), "."))
    packageStartupMessage("A lot has changed since the pre-1.0.0 release on CRAN, please check-out breaking changes here:")
    packageStartupMessage("-> https://ellessenne.github.io/comorbidity/articles/C-changes.html")
  }
}
