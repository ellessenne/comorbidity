#' Generate pseudo-ICD-10 diagnoses.
#'
#' A simple random generator for pseudo-ICD-10 diagnoses.
#'
#' @param n Number of pseudo-ICD-10 codes to generate.
#'
#' @return A vector of \code{n} pseudo-ICD-10 diagnoses.
#' @examples
#' sample_diag(10)
#'
#' @author Alessandro Gasparini, \email{alessandro.gasparini@@ki.se}
#'
#' @export

sample_diag <- function(n = 1){
  return(paste0(sample(LETTERS, n, replace = TRUE), sample(0:9, n, replace = TRUE), sample(0:99, n, replace = TRUE)))
}
