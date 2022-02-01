#' @title Display Currently Supported Algorithms
#'
#' @description This function prints all (currently) supported and implemented
#' comorbidity mapping, and for each one of those, each supported scoring and
#' weighting algorithm.
#'
#' @export
#'
#' @examples
#' available_algorithms()
available_algorithms <- function() {
  available_mappings <- names(.maps)
  cat("Supported comorbidity mapping algorithms:\n")
  for (m in available_mappings) {
    cat("\t*", m, "\n")
  }
  cat("\nSupported scoring weights algorithms:\n")
  for (m in available_mappings) {
    cat("\t* For", paste0(m, ":"), paste(names(.weights[[m]]), collapse = ", "), "\n")
  }
}
