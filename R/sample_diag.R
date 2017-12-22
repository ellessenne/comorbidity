#' @title Generate pseudo-ICD-10 diagnoses.
#'
#' @description A simple function to simulate pseudo-ICD-10 diagnostic codes at random.
#'
#' @param n Number of pseudo-ICD-10 codes to generate.
#'
#' @return A vector of `n` pseudo-ICD-10 diagnoses.
#' @examples
#' # Simulate 10 ICD-10 codes
#' sample_diag(10)
#' 
#' # Simulate a tidy dataset with 15 individuals and 200 rows
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_diag(200),
#'   stringsAsFactors = FALSE)
#' head(x)
#'
#' @export

sample_diag <- function(n = 1){
  return(paste0(sample(LETTERS, n, replace = TRUE), sample(0:9, n, replace = TRUE), sample(0:99, n, replace = TRUE)))
}