#' @keywords internal
.codes_to_regex <- function(x) {
  x <- paste(x, collapse = "|^")
  x <- paste0("^", x)
  return(x)
}
