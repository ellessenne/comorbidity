#' @title Compute comorbidity scores.
#'
#' @description Computes comorbidity scores such as the weighted Charlson score and the Elixhauser comorbidity score.
#'
#' @param x A tidy data frame with one column containing an individual ID and a column containing all diagnostic codes.
#' @param id Column of `x` containing the individual ID.
#' @param code Column of `x` containing diagnostic codes. Codes must be in upper case with no puctuation in order to be properly recognised.
#' @param score The comorbidity score to compute. Possible choices are the weighted Charlson score based on ICD-10 codes (`charlson_icd10`) and the Elixhauser comorbidity score based on ICD-10 codes (`elixhauser_icd10`). Defaults to `charlson_icd10`.
#' @param assign0 Apply a hierarchy of comorbities. If `TRUE`, should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned to 0 and therefore not counted. By doing this, a type of comorbidity is not counted more than once in each patient.
#' @param factorise Return comorbidities as factors rather than numeric, where (1 = presence of comorbidity, 0 = otherwise). Defaults to `FALSE`.
#' @param labelled Attach labels to each comorbidity, compatible with the RStudio viewer via the [utils::View()] function. Defaults to `TRUE`.
#' @param tidy.codes Tidy diagnostic codes? If `TRUE`, all codes are converted to upper case and all non-alphanumeric characters are removed (REGEXPR: \code{[^[:alnum:]]}). Defaults to `TRUE`.
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
#' * `metacanc`, for metastatic solid tumor;
#' * `aids`, for AIDS/HIV;
#' * `score`, for the weighted Charlson score;
#' * `index`, for the grouped Charlson index.
#'
#' Conversely, for the Elixhauser score the dataset contains the following variables:
#' * The `id` variable as defined by the user;
#' * `chf`, for congestive heart failure;
#' * `carit`, for cardiac arrhytmias;
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
#' * `solidtum`, for solid tumor, without metastasis;
#' * `rheumd`, for rheumatoid artritis/collaged vascular disease;
#' * `coag`, for coagulopaty;
#' * `obes`, for obesity;
#' * `wloss`, for weight loss;
#' * `fed`, for fluid and electrolyte disorders;
#' * `blane`, for blood loss anemia;
#' * `dane`, for deficiency anemia;
#' * `alcohol`, for alcohol abuse;
#' * `drug`, for drug abuse;
#' * `psycho`, for psychoses;
#' * `depre`, for depression.
#'
#' Labels are presented to the user when using the RStudio viewer (e.g. via the [utils::View()] function) for convenience.
#'
#' @details
#' This function is based on the ICD-10-based formulations of the Charlson score and Elixhauser score proposed by Quan _et al_. in 2005. Weights for the Charlson score are based on the original formulation by Charlson _et al_. in 1987, while weights for the Elixhauser score are based on work by van Walraven _et al_. Finally, the categorisation of scores and weighted scores is based on work by Menendez _et al_.
#' ICD-10 codes must be in upper case and with no punctuation in order to be properly recognised; set `tidy.codes = TRUE` to properly tidy the codes automatically.
#' To run the calculations in parallel set `parallel = TRUE`. This is based on [parallel::parLapply()], and it is possible to set the number of cores to use via the `mc.cores` argument, which defaults to using all the cores available.
#'
#' @references Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi J-C, et al. _Coding algorithms for defining comorbidities in ICD-9-CM and ICD-10 administrative data_. Medical Care 2005; 43(11):1130-1139.
#' @references Charlson ME, Pompei P, Ales KL, et al. _A new method of classifying prognostic comorbidity in longitudinal studies: development and validation_. Journal of Chronic Diseases 1987; 40:373-383.
#' @references van Walraven C, Austin PC, Jennings A, Quan H and Forster AJ. _A modification of the Elixhauser comorbidity measures into a point system for hospital death using administrative data_. Medical Care 2009; 47(6):626-633.
#' @references Menendez ME, Neuhaus V, van Dijk CN, Ring D. _The Elixhauser comorbidity method outperforms the Charlson index in predicting inpatient death after orthopaedic surgery_. Clinical Orthopaedics and Related Research 2014; 472:2878–2886.
#'
#' @examples
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_diag_icd10(200),
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
  # score must be charlson_icd10, elixhauser_icd10
  checkmate::assert_choice(score, choices = c("charlson_icd10", "elixhauser_icd10"), add = arg_checks)
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

  ### Tidy ICD-10 codes if required
  if (tidy.codes) {
    x[[code]] <- toupper(x[[code]])
    x[[code]] <- gsub(pattern = "[^[:alnum:]]", x = x[[code]], replacement = "")
  } else {
    message("Codes have not been automatically tidied.\nPlease make sure they are all in UPPER CASE and no punctuation is present.")
  }

  ### Compute comorbidity score by id
  # Split by id
  xByID <- split(x, f = x[[id]])
  # Compute using the appropriate algorithm and using parallel computing (if required)
  algorithm <- switch(score,
    "charlson_icd10" = charlson_icd10,
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
  switch(score,
    "charlson_icd10" = {
      cs$score <- with(cs, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc + hp + rend + canc * ifelse(metacanc == 1 & assign0, 0, 1) + msld + metacanc + aids)
      cs$index <- with(cs, cut(score, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
      cs$wscore <- with(cs, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc * 2 + hp * 2 + rend * 2 + canc * ifelse(metacanc == 1 & assign0, 0, 2) + msld * 3 + metacanc * 6 + aids * 6)
      cs$windex <- with(cs, cut(wscore, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
    },
    "elixhauser_icd10" = {
      cs$score <- with(cs, chf + carit + valv + pcd + pvd + hypunc * ifelse(hypc == 1 & assign0, 0, 1) + hypc + para + ond + cpd + diabunc * ifelse(diabc == 1 & assign0, 0, 1) + diabc + hypothy + rf + ld + pud + aids + lymph + metacanc + solidtum * ifelse(metacanc == 1 & assign0, 0, 1) + rheumd + coag + obes + wloss + fed + blane + dane + alcohol + drug + psycho + depre)
      cs$index <- with(cs, cut(score, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
      cs$wscore <- with(cs, chf * 7 + carit * 5 + valv * (-1) + pcd * 4 + pvd * 2 + ifelse(hypc == 1 & assign0, 0, 0) + hypc * 0 + para * 7 + ond * 6 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * 0 + hypothy * 0 + rf * 5 + ld * 11 + pud * 0 + aids * 0 + lymph * 9 + metacanc * 12 + solidtum * ifelse(metacanc == 1 & assign0, 0, 4) + rheumd * 0 + coag * 3 + obes * (-4) + wloss * 6 + fed * 5 + blane * (-2) + dane * (-2) + alcohol * 0 + drug * (-7) + psycho * 0 + depre * (-3))
      cs$windex <- with(cs, cut(wscore, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    }
  )

  ### Factorise comorbidities if requested
  if (factorise == TRUE) {
    cols <- switch(score,
      "charlson_icd10" = c("ami", "chf", "pvd", "cevd", "dementia", "copd", "rheumd", "pud", "mld", "diab", "diabwc", "hp", "rend", "canc", "msld", "metacanc", "aids"),
      "elixhauser_icd10" = c("chf", "carit", "valv", "pcd", "pvd", "hypunc", "hypc", "para", "ond", "cpd", "diabunc", "diabc", "hypothy", "rf", "ld", "pud", "aids", "lymph", "metacanc", "solidtum", "rheumd", "coag", "obes", "wloss", "fed", "blane", "dane", "alcohol", "drug", "psycho", "depre")
    )
    cs[cols] <- lapply(cs[cols], factor, levels = 0:1, labels = c("No", "Yes"))
  }

  ### Label variables for RStudio viewer if requested
  if (labelled) {
    attr(cs, "variable.labels") <- switch(score,
      "charlson_icd10" = c("ID", "Myocardial infarction", "Congestive heart failure", "Peripheral vascular disease", "Cerebrovascular disease", "Dementia", "Chronic obstructive pulmonary disease", "Rheumatoid disease", "Peptic ulcer disease", "Mild liver disease", "Diabetes without chronic complications", "Diabetes with chronic complications", "Hemiplegia or paraplegia", "Renal disease", "Cancer (any malignancy)", "Moderate or severe liver disease", "Metastatic solid tumor", "AIDS/HIV", "Charlson score", "Charlson index", "Weighted Charlson score", "Weighted Charlson index"),
      "elixhauser_icd10" = c("ID", "Congestive heart failure", "Cardiac arrhytmias", "Valvular disease", "Pulmonary circulation disorders", "Peripheral vascular disorders", "Hypertension, uncomplicated", "Hypertension, complicated", "Paralysis", "Other neurological disorders", "Chronic pulmonary disease", "Diabetes, uncomplicated", "Diabetes, complicated", "Hypothyroidism", "Renal failure", "Liver disease", "Peptic ulcer disease excluding bleeding", "AIDS/HIV", "Lymphoma", "Metastatic cancer", "Solid tumor without metastasis", "Rheumatoid artritis/collaged vascular disease", "Coagulopaty", "Obesity", "Weight loss", "Fluid and electrolyte disorders", "Blood loss anemia", "Deficiency anemia", "Alcohol abuse", "Drug abuse", "Psychoses", "Depression", "Elixhauser score", "Elixhauser index", "Weighted Elixhauser score", "Weighted Elixhauser index")
    )
  }

  ### Return a tidy data.frame
  return(cs)
}

#' @keywords internal
charlson_icd10 <- function(x, id, code) {
  ami <- max(grepl("^I21|^I22|^I252", x[[code]]))
  chf <- max(grepl("^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290", x[[code]]))
  pvd <- max(grepl("^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959", x[[code]]))
  cevd <- max(grepl("^G45|^G46|^H340|^I60|^I61|^I62|^I63|^I64|^I65|^I66|^I67|^I68|^I69", x[[code]]))
  dementia <- max(grepl("F00|^F01|^F02|^F03|^F051|^G30|^G311", x[[code]]))
  copd <- max(grepl("I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703", x[[code]]))
  rheumd <- max(grepl("^M05|^M06|^M315|^M32|^M33|^M34|^M351|^M353|^M360", x[[code]]))
  pud <- max(grepl("^K25|^K26|^K27|^K28", x[[code]]))
  mld <- max(grepl("^B18|^K700|^K701|^K702|^K703|^K709|^K713|^K714|^K715|^K717|^K73|^K74|^K760|^K762|^K763|^K764|^K768|^K769|^Z944", x[[code]]))
  diab <- max(grepl("^E100|^E101|^E106|^E108|^E109|^E110|^E111|^E116|^E118|^E119|^E120|^E121|^E126|^E128|^E129|^E130|^E131|^E136|^E138|^E139|^E140|^E141|^E146|^E148|^E149", x[[code]]))
  diabwc <- max(grepl("^E102|^E103|^E104|^E105|^E107|^E112|^E113|^E114|^E115|^E117|^E122|^E123|^E124|^E125|^E127|^E132|^E133|^E134|^E135|^E137|^E142|^E143|^E144|^E145|^E147", x[[code]]))
  hp <- max(grepl("^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839", x[[code]]))
  rend <- max(grepl("^I120|^I131|^N032|^N033|^N034|^N035|^N036|^N037|^N052|^N053|^N054|^N055|^N056|^N057|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992", x[[code]]))
  canc <- max(grepl("^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C81|^C82|^C83|^C84|^C85|^C88|^C90|^C91|^C92|^C93|^C94|^C95|^C96|^C97", x[[code]]))
  msld <- max(grepl("^I850|^I859|^I864|^I982|^K704|^K711|^K721|^K729|^K765|^K766|^K767", x[[code]]))
  metacanc <- max(grepl("^C77|^C78|^C79|^C80", x[[code]]))
  aids <- max(grepl("^B20|^B21|^B22|^B24", x[[code]]))
  out <- list()
  out[[id]] <- unique(x[[id]])
  out$ami <- ami
  out$chf <- chf
  out$pvd <- pvd
  out$cevd <- cevd
  out$dementia <- dementia
  out$copd <- copd
  out$rheumd <- rheumd
  out$pud <- pud
  out$mld <- mld
  out$diab <- diab
  out$diabwc <- diabwc
  out$hp <- hp
  out$rend <- rend
  out$canc <- canc
  out$msld <- msld
  out$metacanc <- metacanc
  out$aids <- aids
  out <- data.frame(out)
  return(out)
}

#' @keywords internal
elixhauser_icd10 <- function(x, id, code) {
  chf <- max(grepl("^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290", x[[code]]))
  carit <- max(grepl("^I441|^I442|^I443|^I456|^I459|^I47|^I48|^I49|^R000|^R001|^R008|^T821|^Z450|^Z950", x[[code]]))
  valv <- max(grepl("^A520|^I05|^I06|^I07|^I08|^I091|^I098|^I34|^I35|^I36|^I37|^I38|^I39|^Q230|^Q231|^Q232|^Q233|^Z952|^Z953|^Z954", x[[code]]))
  pcd <- max(grepl("^I26|^I27|^I280|^I288|^I289", x[[code]]))
  pvd <- max(grepl("^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959", x[[code]]))
  hypunc <- max(grepl("^I10", x[[code]]))
  hypc <- max(grepl("^I11|^I12|^I13|^I15", x[[code]]))
  para <- max(grepl("^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839", x[[code]]))
  ond <- max(grepl("^G10|^G11|^G12|^G13|^G20|^G21|^G22|^G254|^G255|^G312|^G318|^G319|^G32|^G35|^G36|^G37|^G40|^G41|^G931|^G934|^R470|^R56", x[[code]]))
  cpd <- max(grepl("^I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703", x[[code]]))
  diabunc <- max(grepl("^E100|^E101|^E109|^E110|^E111|^E119|^E120|^E121|^E129|^E130|^E131|^E139|^E140|^E141|^E149", x[[code]]))
  diabc <- max(grepl("^E102|^E103|^E104|^E105|^E106|^E107|^E108|^E112|^E113|^E114|^E115|^E116|^E117|^E118|^E122|^E123|^E124|^E125|^E126|^E127|^E128|^E132|^E133|^E134|^E135|^E136|^E137|^E138|^E142|^E143|^E144|^E145|^E146|^E147|^E148", x[[code]]))
  hypothy <- max(grepl("E00|^E01|^E02|^E03|^E890", x[[code]]))
  rf <- max(grepl("^I120|^I131|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992", x[[code]]))
  ld <- max(grepl("^B18|^I85|^I864|^I982|^K70|^K711|^K713|^K714|^K715|^K717|^K72|^K73|^K74|^K760|^K762|^K763|^K764|^K765|^K766|^K767|^K768|^K769|^Z944", x[[code]]))
  pud <- max(grepl("^K257|^K259|^K267|^K269|^K277|^K279|^K287|^K289", x[[code]]))
  aids <- max(grepl("^B20|^B21|^B22|^B24", x[[code]]))
  lymph <- max(grepl("^C81|^C82|^C83|^C84|^C85|^C88|^C96|^C900|^C902", x[[code]]))
  metacanc <- max(grepl("^C77|^C78|^C79|^C80", x[[code]]))
  solidtum <- max(grepl("^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C97", x[[code]]))
  rheumd <- max(grepl("^L940|^L941|^L943|^M05|^M06|^M08|^M120|^M123|^M30|^M310|^M311|^M312|^M313|^M32|^M33|^M34|^M35|^M45|^M461|^M468|^M469", x[[code]]))
  coag <- max(grepl("^D65|^D66|^D67|^D68|^D691|^D693|^D694|^D695|^D696", x[[code]]))
  obes <- max(grepl("^E66", x[[code]]))
  wloss <- max(grepl("^E40|^E41|^E42|^E43|^E44|^E45|^E46|^R634|^R64", x[[code]]))
  fed <- max(grepl("^E222|^E86|^E87", x[[code]]))
  blane <- max(grepl("^D500", x[[code]]))
  dane <- max(grepl("^D508|^D509|^D51|^D52|^D53", x[[code]]))
  alcohol <- max(grepl("^F10|^E52|^G621|^I426|^K292|^K700|^K703|^K709|^T51|^Z502|^Z714|^Z721", x[[code]]))
  drug <- max(grepl("^F11|^F12|^F13|^F14|^F15|^F16|^F18|^F19|^Z715|^Z722", x[[code]]))
  psycho <- max(grepl("^F20|^F22|^F23|^F24|^F25|^F28|^F29|^F302|^F312|^F315", x[[code]]))
  depre <- max(grepl("^F204|^F313|^F314|^F315|^F32|^F33|^F341|^F412|^F432", x[[code]]))
  out <- list()
  out[[id]] <- unique(x[[id]])
  out$chf <- chf
  out$carit <- carit
  out$valv <- valv
  out$pcd <- pcd
  out$pvd <- pvd
  out$hypunc <- hypunc
  out$hypc <- hypc
  out$para <- para
  out$ond <- ond
  out$cpd <- cpd
  out$diabunc <- diabunc
  out$diabc <- diabc
  out$hypothy <- hypothy
  out$rf <- rf
  out$ld <- ld
  out$pud <- pud
  out$aids <- aids
  out$lymph <- lymph
  out$metacanc <- metacanc
  out$solidtum <- solidtum
  out$rheumd <- rheumd
  out$coag <- coag
  out$obes <- obes
  out$wloss <- wloss
  out$fed <- fed
  out$blane <- blane
  out$dane <- dane
  out$alcohol <- alcohol
  out$drug <- drug
  out$psycho <- psycho
  out$depre <- depre
  out <- data.frame(out)
  return(out)
}
