#' @keywords internal
.check_output <- function(x, id) {
  x[[id]] <- NULL
  # Check that all identified comorbidity domains are either 0 or 1
  if (!all(x == 0 | x == 1)) stop("'comorbidity()' ended up in an unexpected state.\nPlease report a bug with a reproducible example at https://github.com/ellessenne/comorbidity/issues\n", call. = FALSE)
}
