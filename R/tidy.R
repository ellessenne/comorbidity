#' @keywords internal
.tidy <- function(x, code) {
  ### Upper case all codes
  x[[code]] <- toupper(x[[code]])

  ### Remove non-alphanumeric characters
  x[[code]] <- gsub(pattern = "[^[:alnum:]]", x = x[[code]], replacement = "")

  ### Return x
  return(x)
}
