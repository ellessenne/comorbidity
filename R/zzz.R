.onAttach <- function(libname, pkgname) {
  tick <- as.numeric(substr(as.character(Sys.time()), 18, 19)) %% 2
  if (tick == 1) {
    packageStartupMessage("This is {comorbidity} version 1.0.0.")
    packageStartupMessage("A lot has changed since the last release on CRAN, please check-out breaking changes here:")
    packageStartupMessage("-> https://ellessenne.github.io/comorbidity/articles/C-changes.html")
  }
}
