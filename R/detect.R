#' @keywords internal
.detect <- function(i, obj, pattern) max(stringi::stri_detect_regex(str = obj[[i]], pattern = pattern))
