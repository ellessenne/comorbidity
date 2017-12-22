#' @title Charlson Comorbidity Score.
#'
#' @description Computes the weighted Charlson Score, using ICD-10 codes.
#'
#' @param x A tidy data frame with one column containing an individual ID and a column containing all ICD-10 codes.
#' @param id Column of `x` containing the individual ID.
#' @param code Column of `x` containing ICD-10 codes. Codes must be in upper case with no puctuation in order to be properly recognised.
#' @param assign0 Apply a hierarchy of comorbities. If `TRUE`, should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned to 0 and therefore not counted. By doing this, a type of comorbidity is not counted more than once in each patient.
#' @param factorise Return comorbidities as factors rather than numeric, where (1 = presence of comorbidity, 0 = otherwise). Defaults to `FALSE`.
#' @param labelled Attach labels to each comorbidity, compatible with the RStudio viewer via the [utils::View()] function. Defaults to `TRUE`.
#' @param tidy.codes Tidy ICD-10 codes? If `TRUE`, all codes are converted to upper case and all punctuation is stipped (REGEXPR: `[[:punct:]]`). Defaults to `TRUE`.
#' @param parallel Run the computation in parallel? Requires the Defaults to `FALSE`.
#' @param mc.cores The number of cores to use when running the computations in parallel. Defaults to all available cores.
#' @return A data frame with `id`, columns relative to each Charlson domain, weighted Charlson Score, and grouped Charlson Index, with one row per individual.
#'
#' @details
#' This function is based on the ICD-10 Charlson Score definition proposed by Quan \emph{et al.} in 2005. ICD-10 codes must be in upper case and with no punctuation in order to be properly recognised; set `tidy.codes = TRUE` to properly tidy the codes automatically.
#' To run the calculations in parallel set `parallel = TRUE`. This is based on [parallel::mclapply()] and works only on Unix systems; set the number of cores to use via the `mc.utils` argument, which defaults to using all the cores available.
#'
#' @references Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi J-C, et al. Coding Algorithms for Defining Comorbidities in ICD-9-CM and ICD-10 Administrative Data. Medical Care 2005; 43:1130-1139.
#'
#' @examples
#' set.seed(1)
#' x <- data.frame(
#'   id = sample(1:15, size = 200, replace = TRUE),
#'   code = sample_diag(200),
#'   stringsAsFactors = FALSE)
#'
#' charlson(x = x, id = "id", code = "code")
#'
#' @export

charlson <- function(x, id, code, assign0 = TRUE, factorise = FALSE, labelled = TRUE, tidy.codes = TRUE, parallel = FALSE, mc.cores = parallel::detectCores()) {
  ### Check arguments
  arg_checks = checkmate::makeAssertCollection()
  # x must be a data.frame
  checkmate::assert_data_frame(x, add = arg_checks)
  # id, code must be a single string value
  checkmate::assert_string(id, add = arg_checks)
  checkmate::assert_string(code, add = arg_checks)
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
  if (!arg_checks$isEmpty())
    checkmate::reportAssertions(arg_checks)
  
  ### Tidy ICD-10 codes if required
  if (tidy.codes) {
    x[[code]] <- toupper(x[[code]])
    x[[code]] <- gsub(pattern = "[[:punct:]]", x = x[[code]], replacement = "")
  } else {
    message("Codes have not been tidied automatically.\nPlease make sure they are all in UPPER CASE and no punctuation is present.")
  }
  
  ### Compute Charlson score by id
  # Split by id
  xByID <- split(x, f = x[[id]])
  # Compute using the appropriate algorithm and using parallel computing (if required)
  cs <- if (parallel) {
    parallel::mclapply(X = xByID, FUN = charlsonICD10, id = id, code = code, mc.cores = mc.cores)
  } else {
    lapply(X = xByID, FUN = charlsonICD10, id = id, code = code)
  }
  # Combine results
  cs <- do.call(rbind.data.frame, c(cs, list(make.row.names = FALSE, stringsAsFactors = FALSE)))
  # Compute Charlson score and Charlson index
  cs$score <- with(cs, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0, 0, 1) + diab * ifelse(diabwc == 1 & assign0, 0, 1) + diabwc * 2 + hp * 2 + rend * 2 + canc * ifelse(metacanc == 1 & assign0, 0, 2) + msld * 3 + metacanc * 6 + aids * 6)
  cs$index <- with(cs, cut(score, breaks = c(0, 1, 2, Inf), labels = c("0", "1", "2+"), right = FALSE))
  
  ### Factorise comorbidities if requested
  if (factorise == TRUE) {
    cols <- c("ami", "chf", "pvd", "cevd", "dementia", "copd", "rheumd", "pud", "mld", "diab", "diabwc", "hp", "rend", "canc", "msld", "metacanc", "aids")
    cs[cols] = lapply(cs[cols], factor, levels = 0:1, labels = c("No", "Yes"))
  }
  
  ### Label variables for RStudio viewer if requested
  if (labelled) attr(cs, "variable.labels") <- c(NA, "Myocardial infarction", "Congestive heart failure", "Peripheral vascular disease", "Cerebrovascular disease", "Dementia", "Chronic obstructive pulmonary disease", "Rheumatoid disease", "Peptic ulcer disease", "Mild liver disease", "Diabetes without chronic complications", "Diabetes with chronic complications", "Hemiplegia or paraplegia", "Renal disease", "Cancer (any malignancy)", "Moderate or severe liver disease", "Metastatic solid tumor", "AIDS/HIV", "Weighted Charlson score", "Grouped Charlson index")

  ### Return a tidy data.frame
  return(cs)
}

#' @keywords internal
charlsonICD10 <- function(x, id, code) {
  ami = max(ifelse(grepl("^I21|^I22|^I252", x[[code]]), 1, 0))
  chf = max(ifelse(grepl("^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290", x[[code]]), 1, 0))
  pvd = max(ifelse(grepl("^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959", x[[code]]), 1, 0))
  cevd = max(ifelse(grepl("^G45|^G46|^H340|^I60|^I61|^I62|^I63|^I64|^I65|^I66|^I67|^I68|^I69", x[[code]]), 1, 0))
  dementia = max(ifelse(grepl("F00|^F01|^F02|^F03|^F051|^G30|^G311", x[[code]]), 1, 0))
  copd = max(ifelse(grepl("I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703", x[[code]]), 1, 0))
  rheumd = max(ifelse(grepl("^M05|^M06|^M315|^M32|^M33|^M34|^M351|^M353|^M360", x[[code]]), 1, 0))
  pud = max(ifelse(grepl("^K25|^K26|^K27|^K28", x[[code]]), 1, 0))
  mld = max(ifelse(grepl("^B18|^K700|^K701|^K702|^K703|^K709|^K713|^K714|^K715|^K717|^K73|^K74|^K760|^K762|^K763|^K764|^K768|^K769|^Z944", x[[code]]), 1, 0))
  diab = max(ifelse(grepl("^E100|^E101|^E106|^E108|^E109|^E110|^E111|^E116|^E118|^E119|^E120|^E121|^E126|^E128|^E129|^E130|^E131|^E136|^E138|^E139|^E140|^E141|^E146|^E148|^E149", x[[code]]), 1, 0))
  diabwc = max(ifelse(grepl("^E102|^E103|^E104|^E105|^E107|^E112|^E113|^E114|^E115|^E117|^E122|^E123|^E124|^E125|^E127|^E132|^E133|^E134|^E135|^E137|^E142|^E143|^E144|^E145|^E147", x[[code]]), 1, 0))
  hp = max(ifelse(grepl("^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839", x[[code]]), 1, 0))
  rend = max(ifelse(grepl("^I120|^I131|^N032|^N033|^N034|^N035|^N036|^N037|^N052|^N053|^N054|^N055|^N056|^N057|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992", x[[code]]), 1, 0))
  canc = max(ifelse(grepl("^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C81|^C82|^C83|^C84|^C85|^C88|^C90|^C91|^C92|^C93|^C94|^C95|^C96|^C97", x[[code]]), 1, 0))
  msld = max(ifelse(grepl("^I850|^I859|^I864|^I982|^K704|^K711|^K721|^K729|^K765|^K766|^K767", x[[code]]), 1, 0))
  metacanc = max(ifelse(grepl("^C77|^C78|^C79|^C80", x[[code]]), 1, 0))
  aids = max(ifelse(grepl("^B20|^B21|^B22|^B24", x[[code]]), 1, 0))
  out = list()
  out[[id]] = unique(x[[id]])
  out$ami = ami
  out$chf = chf 
  out$pvd = pvd 
  out$cevd = cevd
  out$dementia = dementia 
  out$copd = copd
  out$rheumd = rheumd
  out$pud = pud
  out$mld = mld
  out$diab = diab
  out$diabwc = diabwc
  out$hp = hp
  out$rend = rend
  out$canc = canc
  out$msld = msld
  out$metacanc = metacanc
  out$aids = aids
  out = as.data.frame(out)
  return(out)
}
