#' @title Simulate Year and Quarter
#'
#' @description A simple function to simulate Year and Quarter data at random.
#'
#' @param n Number of Year/Quarter pairs to generate.
#'
#' @return A data.frame of with `n` years and quarters.
#' @examples
#' # Simulate 10 Year/Quarter pairs
#' sample_year_quarter(10)
#'
#' # Simulate a tidy dataset with 15 individuals and 200 rows
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   stringsAsFactors = FALSE
#' )
#' x[c('Year', 'Quarter')] = sample_year_quarter(15)[x$id,]
#' head(x)
#' @export

sample_year_quarter <- function(n = 1) {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # n must be a single numeric value
  checkmate::assert_number(n, add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) {
    checkmate::reportAssertions(arg_checks)
  }
  
  ### Sample years/quarters
  as.data.frame(
    list(
      year = sample(2015:2021, n, replace=T),
      quarter = sample(1:4, n, replace=T)
    )
  )
}
