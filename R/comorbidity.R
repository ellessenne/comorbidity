#' @title Compute comorbidity scores.
#'
#' @description Computes comorbidity scores such as the weighted Charlson score and the Elixhauser comorbidity score.
#'
#' @param x A tidy `data.frame` (or a `data.table`; `tibble`s are supported too) with one column containing an individual ID and a column containing all diagnostic codes.
#' Extra columns other than ID and codes are discarded.
#' Column names must be syntactically valid names, otherwise they are forced to be so by calling the [make.names()] function.
#' @param id Column of `x` containing the individual ID.
#' @param code Column of `x` containing diagnostic codes. Codes must be in upper case with no punctuation in order to be properly recognised.
#' @param score The comorbidity score to compute. Possible choices are the weighted Charlson score (`charlson`) and the weighted Elixhauser score (`elixhauser`). Values are case-insensitive.
#' @param assign0 Apply a hierarchy of comorbidities: should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned a value of 0.
#' By doing this, a type of comorbidity is not counted more than once in each patient.
#'
#' If `assign0 = "score"` then the hierarchy will be applied to the score and weighted score only, i.e. the comorbidity domains will not be affected.
#' If `assign0 = "both"` then both domains and scores will be affected.
#' Finally, if `assign0 = "none"` no hierarchy is applied.
#' The previous behaviour (`comorbidity <= 0.5.3`) corresponds to:
#' * `assign0 = "score"` replaces `assign0 = TRUE`,
#' * `assign0 = "none"` replaces `assign0 = FALSE`.
#'
#' The comorbidities that are affected by this argument are:
#' * "Mild liver disease" (`mld`) and "Moderate/severe liver disease" (`msld`) for the Charlson score;
#' * "Diabetes" (`diab`) and "Diabetes with complications" (`diabwc`) for the Charlson score;
#' * "Cancer" (`canc`) and "Metastatic solid tumour" (`metacanc`) for the Charlson score;
#' * "Hypertension, uncomplicated" (`hypunc`) and "Hypertension, complicated" (`hypc`) for the Elixhauser score;
#' * "Diabetes, uncomplicated" (`diabunc`) and "Diabetes, complicated" (`diabc`) for the Elixhauser score;
#' * "Solid tumour" (`solidtum`) and "Metastatic cancer" (`metacanc`) for the Elixhauser score.
#'
#' @param icd The version of ICD coding to use. Possible choices are ICD-9-CM (`icd9`) or ICD-10 (`icd10`). Defaults to `icd10`, and values are case-insensitive.
#' @param factorise Return comorbidities as factors rather than numeric, where (1 = presence of comorbidity, 0 = otherwise). Defaults to `FALSE`.
#' @param labelled Attach labels to each comorbidity, compatible with the RStudio viewer via the [utils::View()] function. Defaults to `TRUE`.
#' @param tidy.codes Tidy diagnostic codes? If `TRUE`, all codes are converted to upper case and all non-alphanumeric characters are removed using the regular expression \code{[^[:alnum:]]}. Defaults to `TRUE`.
#' @return A data frame with `id`, columns relative to each comorbidity domain, comorbidity score, weighted comorbidity score, and categorisations of such scores, with one row per individual.
#'
#' For the Charlson score, the following variables are included in the dataset:
#' * The `id` variable as defined by the user;
#' * `ami`, for acute myocardial infarction;
#' * `chf`, for congestive heart failure;
#' * `pvd`, for peripheral vascular disease;
#' * `cevd`, for cerebrovascular disease;
#' * `dementia`, for dementia;
#' * `copd`, chronic obstructive pulmonary disease;
#' * `rheumd`, for rheumatoid disease;
#' * `pud`, for peptic ulcer disease;
#' * `mld`, for mild liver disease;
#' * `diab`, for diabetes without complications;
#' * `diabwc`, for diabetes with complications;
#' * `hp`, for hemiplegia or paraplegia;
#' * `rend`, for renal disease;
#' * `canc`, for cancer (any malignancy);
#' * `msld`, for moderate or severe liver disease;
#' * `metacanc`, for metastatic solid tumour;
#' * `aids`, for AIDS/HIV;
#' * `score`, for the non-weighted version of the Charlson score;
#' * `index`, for the non-weighted version of the grouped Charlson index;
#' * `wscore`, for the weighted version of the Charlson score;
#' * `windex`, for the weighted version of the grouped Charlson index.
#'
#' Conversely, for the Elixhauser score the dataset contains the following variables:
#' * The `id` variable as defined by the user;
#' * `chf`, for congestive heart failure;
#' * `carit`, for cardiac arrhythmias;
#' * `valv`, for valvular disease;
#' * `pcd`, for pulmonary circulation disorders;
#' * `pvd`, for peripheral vascular disorders;
#' * `hypunc`, for hypertension, uncomplicated;
#' * `hypc`, for hypertension, complicated;
#' * `para`, for paralysis;
#' * `ond`, for other neurological disorders;
#' * `cpd`, for chronic pulmonary disease;
#' * `diabunc`, for diabetes, uncomplicated;
#' * `diabc`, for diabetes, complicated;
#' * `hypothy`, for hypothyroidism;
#' * `rf`, for renal failure;
#' * `ld`, for liver disease;
#' * `pud`, for peptic ulcer disease, excluding bleeding;
#' * `aids`, for AIDS/HIV;
#' * `lymph`, for lymphoma;
#' * `metacanc`, for metastatic cancer;
#' * `solidtum`, for solid tumour, without metastasis;
#' * `rheumd`, for rheumatoid arthritis/collaged vascular disease;
#' * `coag`, for coagulopathy;
#' * `obes`, for obesity;
#' * `wloss`, for weight loss;
#' * `fed`, for fluid and electrolyte disorders;
#' * `blane`, for blood loss anaemia;
#' * `dane`, for deficiency anaemia;
#' * `alcohol`, for alcohol abuse;
#' * `drug`, for drug abuse;
#' * `psycho`, for psychoses;
#' * `depre`, for depression;
#' * `score`, for the non-weighted version of the Elixhauser score;
#' * `index`, for the non-weighted version of the grouped Elixhauser index;
#' * `wscore_ahrq`, for the weighted version of the Elixhauser score using the AHRQ algorithm (Moore _et al_., 2017);
#' * `wscore_vw`, for the weighted version of the Elixhauser score using the algorithm in van Walraven _et al_. (2009);
#' * `windex_ahrq`, for the weighted version of the grouped Elixhauser index using the AHRQ algorithm (Moore _et al_., 2017);
#' * `windex_vw`, for the weighted version of the grouped Elixhauser index using the algorithm in van Walraven _et al_. (2009).
#'
#' Labels are presented to the user when using the RStudio viewer (e.g. via the [utils::View()] function) for convenience.
#'
#' @details
#' The ICD-10 and ICD-9-CM coding for the Charlson and Elixhauser scores is based on work by Quan _et al_. (2005). Weights for the Charlson score are based on the original formulation by Charlson _et al_. in 1987, while weights for the Elixhauser score are based on work by Moore _et al_. and van Walraven _et al_. Finally, the categorisation of scores and weighted scores is based on work by Menendez _et al_. See `vignette("comorbidityscores", package = "comorbidity")` for further details on the comorbidity scores and the weighting algorithm.
#' ICD-10 and ICD-9 codes must be in upper case and with alphanumeric characters only in order to be properly recognised; set `tidy.codes = TRUE` to properly tidy the codes automatically. As a convenience, a message is printed to the R console when non-alphanumeric characters are found.
#'
#' @references Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi JC, et al. _Coding algorithms for defining comorbidities in ICD-9-CM and ICD-10 administrative data_. Medical Care 2005; 43(11):1130-1139.
#' @references Charlson ME, Pompei P, Ales KL, et al. _A new method of classifying prognostic comorbidity in longitudinal studies: development and validation_. Journal of Chronic Diseases 1987; 40:373-383.
#' @references Moore BJ, White S, Washington R, Coenen N, and Elixhauser A. _Identifying increased risk of readmission and in-hospital mortality using hospital administrative data: the AHRQ Elixhauser comorbidity index_. Medical Care 2017; 55(7):698-705.
#' @references van Walraven C, Austin PC, Jennings A, Quan H and Forster AJ. _A modification of the Elixhauser comorbidity measures into a point system for hospital death using administrative data_. Medical Care 2009; 47(6):626-633.
#' @references Menendez ME, Neuhaus V, van Dijk CN, Ring D. _The Elixhauser comorbidity method outperforms the Charlson index in predicting inpatient death after orthopaedic surgery_. Clinical Orthopaedics and Related Research 2014; 472(9):2878-2886.
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
#' comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", assign0 = FALSE)
#'
#' # Elixhauser score based on ICD-10 diagnostic codes:
#' comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", assign0 = FALSE)
#' @export

comorbidity <- function(x, id, code, map, assign0, labelled = TRUE, tidy.codes = TRUE) {

  # x = x
  # id = "id"
  # code = "code"
  # score = "elixhauser"
  # assign0 = "both"
  # icd = "icd10"
  # factorise = FALSE
  # labelled = TRUE
  # tidy.codes = TRUE

  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # x must be a data.frame (or a data.table)
  checkmate::assert_true(all(class(x) %in% c("data.frame", "data.table", "tbl", "tbl_df")), add = arg_checks)
  # id, code, map must be a single string value
  checkmate::assert_string(id, add = arg_checks)
  checkmate::assert_string(code, add = arg_checks)
  checkmate::assert_string(map, add = arg_checks)
  # map must be one of the supported; case insensitive
  map <- tolower(map)
  checkmate::assert_choice(map, choices = c("charlson_icd9", "charlson_icd10", "elixhauser_icd9", "elixhauser_icd10"), add = arg_checks)
  # assign0, labelled, tidy.codes must be a single boolean value
  checkmate::assert_logical(assign0, add = arg_checks)
  checkmate::assert_logical(labelled, len = 1, add = arg_checks)
  checkmate::assert_logical(tidy.codes, len = 1, add = arg_checks)
  # force names to be syntactically valid:
  if (any(names(x) != make.names(names(x)))) {
    names(x) <- make.names(names(x))
    warning("Names of the input dataset 'x' have been modified by make.names(). See ?make.names() for more details.", call. = FALSE)
  }
  if (id != make.names(id)) {
    id <- make.names(id)
    warning("The input 'id' string has been modified by make.names(). See ?make.names() for more details.", call. = FALSE)
  }
  if (code != make.names(code)) {
    code <- make.names(code)
    warning("The input 'id' string has been modified by make.names(). See ?make.names() for more details.", call. = FALSE)
  }
  # id, code must be in x
  checkmate::assert_subset(id, choices = names(x), add = arg_checks)
  checkmate::assert_subset(code, choices = names(x), add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) checkmate::reportAssertions(arg_checks)

  ### Tidy codes if required
  if (tidy.codes) x <- .tidy(x = x, code = code)

  ### Create regex from a list of codes
  regex <- lapply(X = maps[[map]], FUN = .codes_to_regex)

  ### Subset only 'id' and 'code' columns
  if (data.table::is.data.table(x)) {
    x <- x[, c(id, code), with = FALSE]
  } else {
    x <- x[, c(id, code)]
  }

  ### Turn x into a DT
  data.table::setDT(x)

  ### Get list of unique codes used in dataset that match comorbidities
  loc <- sapply(regex, grep, unique(x[[code]]), value = TRUE)
  loc <- utils::stack(loc)
  names(loc)[1] <- code

  ### Merge list with original data.table (data.frame)
  x <- merge(x, loc, all.x = TRUE, allow.cartesian = TRUE)
  x[[code]] <- NULL
  x <- unique(x)

  ### Spread wide
  xin <- x[, c(id, "ind"), with = FALSE]
  xin[, value := 1L]
  x <- data.table::dcast.data.table(xin, stats::as.formula(paste(id, "~ ind")), fill = 0)
  x[["NA"]] <- NULL

  ### Add missing columns
  for (col in names(regex)) {
    if (is.null(x[[col]])) x[[col]] <- 0
  }
  data.table::setcolorder(x, c(id, names(regex)))

  ### Turn internal DT into a DF
  data.table::setDF(x)

  ### Check output for possible unknown-state errors
  .check_output(x = x, id = id)

  ### Label variables for RStudio viewer if requested
  if (labelled) x <- .labelled(x = x, map = map)

  ### Return it, after adding class 'comorbidity' and some attributes
  class(x) <- c(class(x), "comorbidity")
  attr(x = x, which = "map") <- map
  return(x)
}
