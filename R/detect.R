#' @keywords internal
.detect <- function(i, x, pattern) max(stringi::stri_detect_regex(str = x[[i]], pattern = pattern))
