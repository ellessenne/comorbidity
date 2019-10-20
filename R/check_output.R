#' @keywords internal
.check_output <- function(x, id, score) {
  x[[id]] <- NULL
  if (score == "charlson") {
    x[["score"]] <- NULL
    x[["index"]] <- NULL
    x[["wscore"]] <- NULL
    x[["windex"]] <- NULL
  } else if (score == "elixhauser") {
    x[["score"]] <- NULL
    x[["index"]] <- NULL
    x[["wscore_ahrq"]] <- NULL
    x[["wscore_vw"]] <- NULL
    x[["windex_ahrq"]] <- NULL
    x[["windex_vw"]] <- NULL
  }
  # Check that all identified comorbidites are either 0 or 1
  if (!all(x == 0 | x == 1)) stop("'comorbidity' ended up in an unexpected state.\nPlease report a bug with a reproducible example at https://github.com/ellessenne/comorbidity/issues\n", call. = FALSE)
}
