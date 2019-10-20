#' @title Compute comorbidity scores.
#'
#' @description Computes comorbidity scores such as the weighted Charlson score and the Elixhauser comorbidity score.
#'
#' @param x A tidy data frame with one column containing an individual ID and a column containing all diagnostic codes.
#' @param id Column of `x` containing the individual ID.
#' @param code Column of `x` containing diagnostic codes. Codes must be in upper case with no punctuation in order to be properly recognised.
#' @param score The comorbidity score to compute. Possible choices are the weighted Charlson score (`charlson`) and the weighted Elixhauser score (`elixhauser`). Values are case-insensitive.
#' @param icd The version of ICD coding to use. Possible choices are ICD-9-CM (`icd9`) or ICD-10 (`icd10`). Defaults to `icd10`, and values are case-insensitive.
#' @param assign0 Apply a hierarchy of comorbidities. If `TRUE`, should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned to 0 and therefore not counted. By doing this, a type of comorbidity is not counted more than once in each patient. In particular, the comorbidities that are affected by this argument are:
#' * "Mild liver disease" (`mld`) and "Moderate/severe liver disease" (`msld`) for the Charlson score;
#' * "Diabetes" (`diab`) and "Diabetes with complications" (`diabwc`) for the Charlson score;
#' * "Cancer" (`canc`) and "Metastatic solid tumour" (`metacanc`) for the Charlson score;
#' * "Hypertension, uncomplicated" (`hypunc`) and "Hypertension, complicated" (`hypc`) for the Elixhauser score;
#' * "Diabetes, uncomplicated" (`diabunc`) and "Diabetes, complicated" (`diabc`) for the Elixhauser score;
#' * "Solid tumour" (`solidtum`) and "Metastatic cancer" (`metacanc`) for the Elixhauser score.
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
#' comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
#'
#' # Elixhauser score based on ICD-10 diagnostic codes:
#' comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
#' @export

comorbidity <- function(x, id, code, score, icd = "icd10", assign0, factorise = FALSE, labelled = TRUE, tidy.codes = TRUE) {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # x must be a data.frame
  checkmate::assert_data_frame(x, add = arg_checks)
  # id, code, score, icd must be a single string value
  checkmate::assert_string(id, add = arg_checks)
  checkmate::assert_string(code, add = arg_checks)
  checkmate::assert_string(score, add = arg_checks)
  checkmate::assert_string(icd, add = arg_checks)
  # score must be charlson, elixhauser; case insensitive
  score <- tolower(score)
  checkmate::assert_choice(score, choices = c("charlson", "elixhauser"), add = arg_checks)
  # icd must be icd9, icd10; case insensitive
  icd <- tolower(icd)
  checkmate::assert_choice(icd, choices = c("icd9", "icd10"), add = arg_checks)
  # assign0, factorise, labelled, tidy.codes, parallel must be a single boolean value
  checkmate::assert_logical(assign0, len = 1, add = arg_checks)
  checkmate::assert_logical(factorise, len = 1, add = arg_checks)
  checkmate::assert_logical(labelled, len = 1, add = arg_checks)
  checkmate::assert_logical(tidy.codes, len = 1, add = arg_checks)
  # id, code must be in x
  checkmate::assert_subset(id, choices = names(x), add = arg_checks)
  checkmate::assert_subset(code, choices = names(x), add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) checkmate::reportAssertions(arg_checks)

  ### Tidy codes if required
  if (tidy.codes) x <- .tidy(x = x, code = code)

  ### Extract regex for internal use
  regex <- lofregex[[score]][[icd]]

  ### Subset only 'id' and 'code' columns
  x <- x[, c(id, code)]

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

  ### Compute Charlson score and Charlson index
  if (score == "charlson") {
    x$score <- with(x, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc + hp + rend + canc * ifelse(metacanc == 1 & assign0, 0, 1) + msld + metacanc + aids)
    x$index <- with(x, cut(score, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
    x$wscore <- with(x, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc * 2 + hp * 2 + rend * 2 + canc * ifelse(metacanc == 1 & assign0, 0, 2) + msld * 3 + metacanc * 6 + aids * 6)
    x$windex <- with(x, cut(wscore, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
  } else {
    x$score <- with(x, chf + carit + valv + pcd + pvd + hypunc * ifelse(hypc == 1 & assign0, 0, 1) + hypc + para + ond + cpd + diabunc * ifelse(diabc == 1 & assign0, 0, 1) + diabc + hypothy + rf + ld + pud + aids + lymph + metacanc + solidtum * ifelse(metacanc == 1 & assign0, 0, 1) + rheumd + coag + obes + wloss + fed + blane + dane + alcohol + drug + psycho + depre)
    x$index <- with(x, cut(score, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    x$wscore_ahrq <- with(x, chf * 9 + carit * 0 + valv * 0 + pcd * 6 + pvd * 3 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * (-1) + para * 5 + ond * 5 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * (-3) + hypothy * 0 + rf * 6 + ld * 4 + pud * 0 + aids * 0 + lymph * 6 + metacanc * 14 + solidtum * ifelse(metacanc == 1 & assign0, 0, 7) + rheumd * 0 + coag * 11 + obes * (-5) + wloss * 9 + fed * 11 + blane * (-3) + dane * (-2) + alcohol * (-1) + drug * (-7) + psycho * (-5) + depre * (-5))
    x$wscore_vw <- with(x, chf * 7 + carit * 5 + valv * (-1) + pcd * 4 + pvd * 2 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * 0 + para * 7 + ond * 6 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * 0 + hypothy * 0 + rf * 5 + ld * 11 + pud * 0 + aids * 0 + lymph * 9 + metacanc * 12 + solidtum * ifelse(metacanc == 1 & assign0, 0, 4) + rheumd * 0 + coag * 3 + obes * (-4) + wloss * 6 + fed * 5 + blane * (-2) + dane * (-2) + alcohol * 0 + drug * (-7) + psycho * 0 + depre * (-3))
    x$windex_ahrq <- with(x, cut(wscore_ahrq, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    x$windex_vw <- with(x, cut(wscore_vw, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
  }

  ### Check output for possible unknown-state errors
  .check_output(x = x, id = id, score = score)

  ### Factorise comorbidities if requested
  if (factorise) x <- .factorise(x = x, score = score)

  ### Label variables for RStudio viewer if requested
  if (labelled) x <- .labelled(x = x, score = score)

  ### Return a tidy data.frame
  return(x)
}
