# Quiets concerns of R CMD check regarding 'no visible binding for global variable ...'
if (getRversion() >= "2.15.1") utils::globalVariables(c("icd10_2009", "icd10_2011"))

#' @title Simulate ICD-10 diagnostic codes
#'
#' @description A simple function to simulate ICD-10 diagnostic codes at random.
#'
#' @param n Number of ICD-10 codes to simulate.
#' @param version The version of the ICD-10 coding scheme to use. Possible choices are `2009` and `2011`; defaults to `2011`. See [comorbidity::icd10_2009] and [comorbidity::icd10_2011] for further information on the different schemes.
#'
#' @return A vector of `n` ICD-10 diagnostic codes.
#' @examples
#' # Simulate 10 ICD-10 codes
#' sample_diag_icd10(10)
#'
#' # Simulate a tidy dataset with 15 individuals and 200 rows
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_diag_icd10(n = 200),
#'   stringsAsFactors = FALSE)
#' head(x)
#'
#' @export

sample_diag_icd10 <- function(n = 1, version = "2011") {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # n must be a single numeric value
  checkmate::assert_number(n, add = arg_checks)
  # version must be "2009" or "2011"
  checkmate::assert_choice(version, choices = c("2009", "2011"), add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) {
    checkmate::reportAssertions(arg_checks)
  }

  ### Sample codes
  switch(version,
    "2009" = {
      utils::data("icd10_2009", package = "comorbidity", envir = environment())
      sample(
        x = icd10_2009$Code.clean,
        size = n,
        replace = TRUE
      )
    },
    "2011" = {
      utils::data("icd10_2011", package = "comorbidity", envir = environment())
      sample(
        x = icd10_2011$Code.clean,
        size = n,
        replace = TRUE
      )
    }
  )
}
