#' @keywords internal
.tidy <- function(x, code) {
  ### Upper case all codes
  x[[code]] <- stringi::stri_trans_toupper(x[[code]])
  ### Remove non-alphanumeric characters
  x[[code]] <- stringi::stri_replace_all_charclass(str = x[[code]], pattern = "[^a-zA-Z0-9]", replacement = "")
  ### Return x
  return(x)
}
