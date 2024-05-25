#' @import checkmate data.table stats stringi utils
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL

# Quiets concerns of R CMD check re: variable names used internally
if (getRversion() >= "2.15.1") utils::globalVariables(c(":=", "..mv", "..mvb", "NA", "canc", "diab", "diabc", "diabunc", "diabwc", "hypc", "hypunc", "metacanc", "mld", "msld", "solidtum", "value"))

#' @keywords internal
.datatable.aware <- TRUE
