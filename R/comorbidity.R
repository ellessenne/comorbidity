#' @title Compute comorbidity scores.
#'
#' @description Computes comorbidity scores such as the weighted Charlson score and the Elixhauser comorbidity score.
#'
#' @param x A tidy data frame with one column containing an individual ID and a column containing all diagnostic codes.
#' @param id Column of `x` containing the individual ID.
#' @param code Column of `x` containing diagnostic codes. Codes must be in upper case with no punctuation in order to be properly recognised.
#' @param score The comorbidity score to compute. Possible choices are the weighted Charlson score based on ICD-10 codes (`charlson_icd10`) or ICD-9 codes (`charlson_icd9`), and the Elixhauser comorbidity score based on ICD-10 codes (`elixhauser_icd10`) or ICD-9 codes (`elixhauser_icd9`). Defaults to `charlson_icd10`.
#' @param assign0 Apply a hierarchy of comorbidities. If `TRUE`, should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned to 0 and therefore not counted. By doing this, a type of comorbidity is not counted more than once in each patient.
#' @param factorise Return comorbidities as factors rather than numeric, where (1 = presence of comorbidity, 0 = otherwise). Defaults to `FALSE`.
#' @param labelled Attach labels to each comorbidity, compatible with the RStudio viewer via the [utils::View()] function. Defaults to `TRUE`.
#' @param tidy.codes Tidy diagnostic codes? If `TRUE`, all codes are converted to upper case and all non-alphanumeric characters are removed using the regular expression \code{[^[:alnum:]]}. Defaults to `TRUE`.
#' @param parallel Run the computation in parallel? See the `Notes` section for more information. Defaults to `FALSE`.
#' @param mc.cores The number of cores to use when running the computations in parallel. Defaults to all available cores.
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
#' * `score`, for the weighted Charlson score;
#' * `index`, for the grouped Charlson index.
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
#' * `depre`, for depression.
#'
#' Labels are presented to the user when using the RStudio viewer (e.g. via the [utils::View()] function) for convenience.
#'
#' @details
#' The ICD-10 and ICD-9-CM coding for the Charlson and Elixhauser scores is based on work by Quan _et al_. (2005). Weights for the Charlson score are based on the original formulation by Charlson _et al_. in 1987, while weights for the Elixhauser score are based on work by Moore _et al_. and van Walraven _et al_. Finally, the categorisation of scores and weighted scores is based on work by Menendez _et al_.
#' ICD-10 and ICD-9 codes must be in upper case and with alphanumeric characters only in order to be properly recognised; set `tidy.codes = TRUE` to properly tidy the codes automatically. As a convenience, a message is printed to the R console when non-alphanumeric characters are found.
#' To run the calculations in parallel set `parallel = TRUE`. This is based on [parallel::parLapply()], and it is possible to set the number of cores to use via the `mc.cores` argument, which defaults to using all the cores available.
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
#'   stringsAsFactors = FALSE)
#'
#' # Charlson score based on ICD-10 diagnostic codes:
#' comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")
#'
#' # Elixhauser score based on ICD-10 diagnostic codes:
#' comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10")
#'
#' @export

comorbidity <- function(x, id, code, score, assign0 = TRUE, factorise = FALSE, labelled = TRUE, tidy.codes = TRUE, parallel = FALSE, mc.cores = parallel::detectCores()) {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # x must be a data.frame
  checkmate::assert_data_frame(x, add = arg_checks)
  # id, code must be a single string value
  checkmate::assert_string(id, add = arg_checks)
  checkmate::assert_string(code, add = arg_checks)
  # score must be charlson_icd9, charlson_icd10, elixhauser_icd10
  checkmate::assert_choice(score, choices = c("charlson_icd9", "charlson_icd10", "elixhauser_icd9", "elixhauser_icd10"), add = arg_checks)
  # assign0, factorise, labelled, tidy.codes, parallel must be a single boolean value
  checkmate::assert_logical(assign0, len = 1, add = arg_checks)
  checkmate::assert_logical(factorise, len = 1, add = arg_checks)
  checkmate::assert_logical(labelled, len = 1, add = arg_checks)
  checkmate::assert_logical(tidy.codes, len = 1, add = arg_checks)
  checkmate::assert_logical(parallel, len = 1, add = arg_checks)
  # mc.cores must be a single numeric value
  checkmate::assert_number(mc.cores, add = arg_checks)
  # id, code must be in x
  checkmate::assert_subset(id, choices = names(x), add = arg_checks)
  checkmate::assert_subset(code, choices = names(x), add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) {
    checkmate::reportAssertions(arg_checks)
  }

  ### Message when non-[[:alnum:]] characters are found in x[[code]]
  nonalnum <- gsub(pattern = "[[:alnum:]]", x = x[[code]], replacement = "")
  nonalnum <- strsplit(x = nonalnum, split = "")
  nonalnum <- unlist(nonalnum)
  if (length(nonalnum) > 0) {
    nonalnum <- unique(nonalnum)
    nonalnum <- paste(nonalnum, collapse = "")
    message("The following non-alphanumeric characters have been found: ", nonalnum)
  }

  ### Tidy ICD-10 codes if required
  if (tidy.codes) {
    x[[code]] <- toupper(x[[code]])
    x[[code]] <- gsub(pattern = "[^[:alnum:]]", x = x[[code]], replacement = "")
  } else {
    message("Codes have not been automatically tidied.\nPlease make sure they are all in UPPER CASE and remove non-alphanumeric characters.")
  }

  ### Compute comorbidity score by id
  # Split by id
  xByID <- split(x, f = x[[id]])
  # Compute using the appropriate algorithm and using parallel computing (if required)
  algorithm <- switch(score,
    "charlson_icd9" = charlson_icd9,
    "charlson_icd10" = charlson_icd10,
    "elixhauser_icd9" = elixhauser_icd9,
    "elixhauser_icd10" = elixhauser_icd10
  )
  if (parallel) {
    cl <- parallel::makeCluster(mc.cores)
    cs <- parallel::parLapply(cl = cl, X = xByID, fun = algorithm, id = id, code = code)
    parallel::stopCluster(cl)
  } else {
    cs <- lapply(X = xByID, FUN = algorithm, id = id, code = code)
  }
  # Combine results
  cs <- do.call(rbind.data.frame, c(cs, list(make.row.names = FALSE, stringsAsFactors = FALSE)))
  # Compute Charlson score and Charlson index
  if (score %in% c("charlson_icd9", "charlson_icd10")) {
    cs$score <- with(cs, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc + hp + rend + canc * ifelse(metacanc == 1 & assign0, 0, 1) + msld + metacanc + aids)
    cs$index <- with(cs, cut(score, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
    cs$wscore <- with(cs, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc * 2 + hp * 2 + rend * 2 + canc * ifelse(metacanc == 1 & assign0, 0, 2) + msld * 3 + metacanc * 6 + aids * 6)
    cs$windex <- with(cs, cut(wscore, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
  } else if (score %in% c("elixhauser_icd9", "elixhauser_icd10")) {
    cs$score <- with(cs, chf + carit + valv + pcd + pvd + hypunc * ifelse(hypc == 1 & assign0, 0, 1) + hypc + para + ond + cpd + diabunc * ifelse(diabc == 1 & assign0, 0, 1) + diabc + hypothy + rf + ld + pud + aids + lymph + metacanc + solidtum * ifelse(metacanc == 1 & assign0, 0, 1) + rheumd + coag + obes + wloss + fed + blane + dane + alcohol + drug + psycho + depre)
    cs$index <- with(cs, cut(score, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    cs$wscore <- with(cs, chf * 3 + carit * 5 + valv * 0 + pcd * 6 + pvd * 3 + hypunc * ifelse(hypc == 1 & assign0, 0, -1) + hypc * (-1) + para * 5 + ond * 5 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * (-3) + hypothy * 0 + rf * 6 + ld * 4 + pud * 0 + aids * 0 + lymph * 6 + metacanc * 14 + solidtum * ifelse(metacanc == 1 & assign0, 0, 7) + rheumd * 0 + coag * 11 + obes * (-5) + wloss * 9 + fed * 11 + blane * (-3) + dane * (-2) + alcohol * (-1) + drug * (-7) + psycho * (-5) + depre * (-5))
    cs$windex <- with(cs, cut(wscore, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
  }

  ### Factorise comorbidities if requested
  if (factorise == TRUE) {
    cols <- if (score %in% c("charlson_icd9", "charlson_icd10")) {
      c("ami", "chf", "pvd", "cevd", "dementia", "copd", "rheumd", "pud", "mld", "diab", "diabwc", "hp", "rend", "canc", "msld", "metacanc", "aids")
    } else if (score %in% c("elixhauser_icd9", "elixhauser_icd10")) {
      c("chf", "carit", "valv", "pcd", "pvd", "hypunc", "hypc", "para", "ond", "cpd", "diabunc", "diabc", "hypothy", "rf", "ld", "pud", "aids", "lymph", "metacanc", "solidtum", "rheumd", "coag", "obes", "wloss", "fed", "blane", "dane", "alcohol", "drug", "psycho", "depre")
    }
    cs[cols] <- lapply(cs[cols], factor, levels = 0:1, labels = c("No", "Yes"))
  }

  ### Label variables for RStudio viewer if requested
  if (labelled) {
    attr(cs, "variable.labels") <- if (score %in% c("charlson_icd9", "charlson_icd10")) {
      c("ID", "Myocardial infarction", "Congestive heart failure", "Peripheral vascular disease", "Cerebrovascular disease", "Dementia", "Chronic obstructive pulmonary disease", "Rheumatoid disease", "Peptic ulcer disease", "Mild liver disease", "Diabetes without chronic complications", "Diabetes with chronic complications", "Hemiplegia or paraplegia", "Renal disease", "Cancer (any malignancy)", "Moderate or severe liver disease", "Metastatic solid tumour", "AIDS/HIV", "Charlson score", "Charlson index", "Weighted Charlson score", "Weighted Charlson index")
    } else if (score %in% c("elixhauser_icd9", "elixhauser_icd10")) {
      c("ID", "Congestive heart failure", "Cardiac arrhythmias", "Valvular disease", "Pulmonary circulation disorders", "Peripheral vascular disorders", "Hypertension, uncomplicated", "Hypertension, complicated", "Paralysis", "Other neurological disorders", "Chronic pulmonary disease", "Diabetes, uncomplicated", "Diabetes, complicated", "Hypothyroidism", "Renal failure", "Liver disease", "Peptic ulcer disease excluding bleeding", "AIDS/HIV", "Lymphoma", "Metastatic cancer", "Solid tumour without metastasis", "Rheumatoid artritis/collaged vascular disease", "Coagulopathy", "Obesity", "Weight loss", "Fluid and electrolyte disorders", "Blood loss anaemia", "Deficiency anaemia", "Alcohol abuse", "Drug abuse", "Psychoses", "Depression", "Elixhauser score", "Elixhauser index", "Weighted Elixhauser score", "Weighted Elixhauser index")
    }
  }

  ### Return a tidy data.frame
  return(cs)
}
