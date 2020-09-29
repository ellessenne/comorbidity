#' @title Simulate DRG codes
#'
#' @description A simple function to simulate DRG codes at random.
#'
#' @param n Number of DRG codes to simulate.
#'
#' @return A vector of `n` DRG diagnostic codes.
#' @examples
#' # Simulate 10 DRG codes
#' sample_drg(10)
#'
#' # Simulate a tidy dataset with 15 individuals and 200 rows
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_drg(n = 200),
#'   stringsAsFactors = FALSE
#' )
#' head(x)
#' @export

sample_drg <- function(n = 1) {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # n must be a single numeric value
  checkmate::assert_number(n, add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) {
    checkmate::reportAssertions(arg_checks)
  }

  ### Sample DRG codes
  sample(unlist(lofmsdrg), n, replace=T)
}
