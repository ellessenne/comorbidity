# Quiets concerns of R CMD check regarding 'no visible binding for global variable ...'
if (getRversion() >= "2.15.1") utils::globalVariables(c("icd10_2009", "icd10_2011", "icd9_2015"))

#' @title Simulate ICD-10 and ICD-9 diagnostic codes
#'
#' @description A simple function to simulate ICD-10 and ICD-9 diagnostic codes at random.
#'
#' @param n Number of ICD codes to simulate.
#' @param version The version of the ICD coding scheme to use. Possible choices are `ICD10_2009`, `ICD10_2011`, and `ICD9_2015`; defaults to `ICD10_2011`. See [comorbidity::icd10_2009], [comorbidity::icd10_2011], and [comorbidity::icd9_2015] for further information on the different schemes.
#'
#' @return A vector of `n` ICD diagnostic codes.
#' @examples
#' # Simulate 10 ICD-10 codes
#' sample_diag(10)
#'
#' # Simulate a tidy dataset with 15 individuals and 200 rows
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_diag(n = 200),
#'   stringsAsFactors = FALSE
#' )
#' head(x)
#' @export

sample_diag <- function(n = 1, version = "ICD10_2011") {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # n must be a single numeric value
  checkmate::assert_number(n, add = arg_checks)
  # version must be "ICD10_2009", "ICD10_2011", "ICD9_2015"
  checkmate::assert_choice(version, choices = c("ICD10_2009", "ICD10_2011", "ICD9_2015"), add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) {
    checkmate::reportAssertions(arg_checks)
  }

  ### Sample codes
  switch(version,
    "ICD10_2009" = {
      utils::data("icd10_2009", package = "comorbidity", envir = environment())
      sample(
        x = icd10_2009$Code.clean,
        size = n,
        replace = TRUE
      )
    },
    "ICD10_2011" = {
      utils::data("icd10_2011", package = "comorbidity", envir = environment())
      sample(
        x = icd10_2011$Code.clean,
        size = n,
        replace = TRUE
      )
    },
    "ICD9_2015" = {
      utils::data("icd9_2015", package = "comorbidity", envir = environment())
      sample(
        x = icd9_2015$Code,
        size = n,
        replace = TRUE
      )
    }
  )
}
