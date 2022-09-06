#' @title Compute (weighted) comorbidity scores
#'
#' @param x An object of class `comorbidty` returned by a call to the [comorbidity()] function.
#'
#' @param weights A string denoting the weighting system to be used, which will depend on the mapping algorithm.
#'
#' Possible values for the Charlson index are:
#' * `charlson`, for the original weights by Charlson et al. (1987);
#' * `quan`, for the revised weights by Quan et al. (2011).
#'
#' Possible values for the Elixhauser score are:
#' * `vw`, for the weights by van Walraven et al. (2009);
#' * `swiss`, for the Swiss Elixhauser weights by Sharma et al. (2021).
#'
#' Defaults to `NULL`, in which case an unweighted score will be used.
#'
#' @param assign0 A logical value denoting whether to apply a hierarchy of comorbidities: should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned a value of 0 when calculating the score.
#' By doing this, a type of comorbidity is not counted more than once in each patient.
#' If `assign0 = TRUE`, the comorbidities that are affected by this argument are:
#' * "Mild liver disease" (`mld`) and "Moderate/severe liver disease" (`msld`) for the Charlson score;
#' * "Diabetes" (`diab`) and "Diabetes with complications" (`diabwc`) for the Charlson score;
#' * "Cancer" (`canc`) and "Metastatic solid tumour" (`metacanc`) for the Charlson score;
#' * "Hypertension, uncomplicated" (`hypunc`) and "Hypertension, complicated" (`hypc`) for the Elixhauser score;
#' * "Diabetes, uncomplicated" (`diabunc`) and "Diabetes, complicated" (`diabc`) for the Elixhauser score;
#' * "Solid tumour" (`solidtum`) and "Metastatic cancer" (`metacanc`) for the Elixhauser score.
#'
#' @references Charlson ME, Pompei P, Ales KL, et al. _A new method of classifying prognostic comorbidity in longitudinal studies: development and validation_. Journal of Chronic Diseases 1987; 40:373-383.
#' @references Quan H, Li B, Couris CM, et al. _Updating and validating the Charlson Comorbidity Index and Score for risk adjustment in hospital discharge abstracts using data from 6 countries_. American Journal of Epidemiology 2011; 173(6):676-682.
#' @references van Walraven C, Austin PC, Jennings A, Quan H and Forster AJ. _A modification of the Elixhauser comorbidity measures into a point system for hospital death using administrative data_. Medical Care 2009; 47(6):626-633.
#' @references Sharma N, Schwendimann R, Endrich O, et al. _Comparing Charlson and Elixhauser comorbidity indices with different weightings to predict in-hospital mortality: an analysis of national inpatient data_. BMC Health Services Research 2021; 21(13).
#'
#' @return A numeric vector with the (possibly weighted) comorbidity score for each subject from the input dataset.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_diag(200),
#'   stringsAsFactors = FALSE
#' )
#'
#' # Charlson score based on ICD-10 diagnostic codes:
#' x1 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
#' score(x = x1, weights = "charlson", assign0 = FALSE)
#'
#' # Elixhauser score based on ICD-10 diagnostic codes:
#' x2 <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
#' score(x = x2, weights = "vw", assign0 = FALSE)
#'
#' # Checking the `assign0` argument.
#' # Please make sure to check the example in the documentation of the
#' # `comorbidity()` function first, with ?comorbidity().
#' # We use the same dataset for a single subject with two codes, for
#' # complicated and uncomplicated diabetes:
#' x3 <- data.frame(
#'   id = 1,
#'   code = c("E100", "E102"),
#'   stringsAsFactors = FALSE
#' )
#' # Then, we calculate the Quan-ICD10 Charlson score:
#' ccF <- comorbidity(x = x3, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
#' ccF[, c("diab", "diabwc")]
#' # If we calculate the unweighted score with `assign0 = FALSE`, both diabetes
#' # conditions are counted:
#' score(x = ccF, assign0 = FALSE)
#' # Conversely, with `assign0 = TRUE`, only the most severe is considered:
#' score(x = ccF, assign0 = TRUE)
score <- function(x, weights = NULL, assign0) {
  ### First, check the function is getting a 'comorbidity' data.frame
  if (!inherits(x = x, what = "comorbidity")) {
    stop("This function can only be used on an object of class 'comorbidity', which you can obtain by using the 'comorbidity()' function. See ?comorbidity for more details.", call. = FALSE)
  }
  ### Identify scoring algorithm
  map <- attr(x, "map")
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # check class of 'x' again, better safe then sorry
  checkmate::assert_class(x, classes = "comorbidity", add = arg_checks)
  # weights must be a single string value
  checkmate::assert_string(weights, null.ok = TRUE, add = arg_checks)
  # weights must be one of the supported; case insensitive
  if (!is.null(weights)) {
    weights <- stringi::stri_trans_tolower(weights)
  }
  checkmate::assert_choice(weights, choices = names(.weights[[map]]), null.ok = TRUE, add = arg_checks)
  # assign0 be a single boolean value
  checkmate::assert_logical(assign0, add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) checkmate::reportAssertions(arg_checks)

  # If weights = NULL, then do non-weighted scores
  if (is.null(weights)) {
    ww <- rep(1, length(.maps[[map]]))
    names(ww) <- names(.maps[[map]])
  } else {
    ww <- .weights[[map]][[weights]]
  }
  ww <- matrix(data = ww, ncol = 1)

  # If assign0, first do that to the input dataset
  x <- x[, names(.maps[[map]])]
  if (assign0) {
    data.table::setDT(x)
    x <- .assign0(x = x, map = map)
    data.table::setDF(x)
  }

  # Calculate score using matrix multiplication
  score <- as.matrix(x) %*% ww
  score <- drop(score)
  attr(score, "map") <- map
  attr(score, "weights") <- weights

  # Return score
  return(score)
}
