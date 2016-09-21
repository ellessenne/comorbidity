#' Charlson Comorbidity Score.
#'
#' \code{charlson} computes the weighted Charlson Score, using ICD-10 codes.
#'
#' @param x A data frame, with one column containing an individual ID and a column containing all ICD-10 codes.
#' @param id Column of \code{x} containing the individual ID.
#' @param code Column of \code{x} containing ICD-10 codes. Codes must be in upper case with no puctuation in order to be properly recognised.
#' @param assign0 Apply a hierarchy of comorbities. If \code{TRUE}, should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned to 0 and therefore not counted. By doing this, a type of comorbidity is not counted more than once in each patient.
#' @param labels Return a dataset with labelled columns. Defaults to \code{TRUE}, and the ID column never gets labelled. The package \code{Hmisc} is required for labeling: if it is not available, a warning will be thrown and variables will not be labelled.
#' @param factorise Return comorbidities as factors rather than numeric, where (1 = presence of comorbidity, 0 = otherwise). Defaults to \code{TRUE}.
#'
#' @return A data frame with \code{id}, columns relative to each Charlson domain, weighted Charlson Score, and grouped Charlson Index, with one row per individual.
#'
#' @details
#' This function is based on the ICD-10 Charlson Score definition proposed by Quan \emph{et al.} in 2005. ICD-10 codes must be in upper case and with no punctuation in order to be properly recognised; use the \code{stringr} package and \code{stringr::str_to_upper()} to turn codes into upper case, \code{stringr::str_replace_all(codes, "[:punct:]", "")} to strip all punctuation. If \code{stringr} is installed in the system, this is done automatically; otherwise, a warning is thrown.
#'
#' @author Alessandro Gasparini, \email{alessandro.gasparini@@ki.se}
#'
#' @references Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi J-C, et al. Coding Algorithms for Defining Comorbidities in ICD-9-CM and ICD-10 Administrative Data. Medical Care 2005; 43:1130-1139.
#'
#' @examples
#' fake_data <- data.frame(
#'  id = sample(1:5, size = 100, replace = TRUE),
#'  code = sample_diag(100))
#'
#' charlson(fake_data, "id", "code")
#'
#' @import dplyr ArgumentCheck lazyeval
#'
#' @export

charlson <- function(x, id, code, assign0 = TRUE, labels = TRUE, factorise = TRUE){

  Check <- ArgumentCheck::newArgCheck()

  # 'x' must be a data frame
  if (!("data.frame" %in% class(x)))
    ArgumentCheck::addError(
      msg = "'x' is not a data.frame.",
      argcheck = Check
    )

  # 'id' must be in 'x'
  if (!(id %in% names(x)))
    ArgumentCheck::addError(
      msg = "'id' not in x.",
      argcheck = Check
    )

  # 'code' must be in 'x'
  if (!(code %in% names(x)))
    ArgumentCheck::addError(
      msg = "'code' not in x.",
      argcheck = Check
    )

  # assign0 must be logical
  if (!(is.logical(assign0)))
    ArgumentCheck::addError(
      msg = "'assign0' not logical.",
      argcheck = Check
    )

  # labels must be logical
  if (!(is.logical(labels)))
    ArgumentCheck::addError(
      msg = "'labels' not logical.",
      argcheck = Check
    )

  # factorise must be logical
  if (!(is.logical(factorise)))
    ArgumentCheck::addError(
      msg = "'factorise' not logical.",
      argcheck = Check
    )

  # return errors and warnings (if any)
  ArgumentCheck::finishArgCheck(Check)

  # tidy ICD-10 codes if stringr is available
  if (requireNamespace("stringr", quietly = TRUE)) {
    x <- x %>%
      mutate_(code = interp(~stringr::str_replace_all(stringr::str_to_lower(var), "[:punct:]", ""), var = as.name(code)))
  } else {
    warning("Package 'stringr' not available. Check case and punctuation in ICD-10 codes.")
  }

  # NULL-ify global variables to avoid CRAN's 'no visible binding for global variable' note
  ami <- NULL; chf <- NULL; pvd <- NULL; cevd <- NULL; dementia <- NULL; copd <- NULL; rheumd <- NULL; pud <- NULL; mld <- NULL; msld <- NULL; diab <- NULL; diabwc <- NULL; hp <- NULL; rend <- NULL; canc <- NULL; metacanc <- NULL; aids <- NULL; score <- NULL;

  # compute the Charlson score
  cs <- x %>%
    group_by_(id) %>%
    summarise_(ami = interp(~max(grepl("^I21|^I22|^I252", var)), var = as.name(code)),
               chf = interp(~max(grepl("^I099|^I110|^I130|^I132|^I255|^I420|^I425|^I426|^I427|^I428|^I429|^I43|^I50|^P290", var)), var = as.name(code)),
               pvd = interp(~max(grepl("^I70|^I71|^I731|^I738|^I739|^I771|^I790|^I792|^K551|^K558|^K559|^Z958|^Z959", var)), var = as.name(code)),
               cevd = interp(~max(grepl("^G45|^G46|^H340|^I60|^I61|^I62|^I63|^I64|^I65|^I66|^I67|^I68|^I69", var)), var = as.name(code)),
               dementia = interp(~max(grepl("F00|^F01|^F02|^F03|^F051|^G30|^G311", var)), var = as.name(code)),
               copd = interp(~max(grepl("I278|^I279|^J40|^J41|^J42|^J43|^J44|^J45|^J46|^J47|^J60|^J61|^J62|^J63|^J64|^J65|^J66|^J67|^J684|^J701|^J703", var)), var = as.name(code)),
               rheumd = interp(~max(grepl("^M05|^M06|^M315|^M32|^M33|^M34|^M351|^M353|^M360", var)), var = as.name(code)),
               pud = interp(~max(grepl("^K25|^K26|^K27|^K28", var)), var = as.name(code)),
               mld = interp(~max(grepl("^B18|^K700|^K701|^K702|^K703|^K709|^K713|^K714|^K715|^K717|^K73|^K74|^K760|^K762|^K763|^K764|^K768|^K769|^Z944", var)), var = as.name(code)),
               diab = interp(~max(grepl("^E100|^E101|^E106|^E108|^E109|^E110|^E111|^E116|^E118|^E119|^E120|^E121|^E126|^E128|^E129|^E130|^E131|^E136|^E138|^E139|^E140|^E141|^E146|^E148|^E149", var)), var = as.name(code)),
               diabwc = interp(~max(grepl("^E102|^E103|^E104|^E105|^E107|^E112|^E113|^E114|^E115|^E117|^E122|^E123|^E124|^E125|^E127|^E132|^E133|^E134|^E135|^E137|^E142|^E143|^E144|^E145|^E147", var)), var = as.name(code)),
               hp = interp(~max(grepl("^G041|^G114|^G801|^G802|^G81|^G82|^G830|^G831|^G832|^G833|^G834|^G839", var)), var = as.name(code)),
               rend = interp(~max(grepl("^I120|^I131|^N032|^N033|^N034|^N035|^N036|^N037|^N052|^N053|^N054|^N055|^N056|^N057|^N18|^N19|^N250|^Z490|^Z491|^Z492|^Z940|^Z992", var)), var = as.name(code)),
               canc = interp(~max(grepl("^C00|^C01|^C02|^C03|^C04|^C05|^C06|^C07|^C08|^C09|^C10|^C11|^C12|^C13|^C14|^C15|^C16|^C17|^C18|^C19|^C20|^C21|^C22|^C23|^C24|^C25|^C26|^C30|^C31|^C32|^C33|^C34|^C37|^C38|^C39|^C40|^C41|^C43|^C45|^C46|^C47|^C48|^C49|^C50|^C51|^C52|^C53|^C54|^C55|^C56|^C57|^C58|^C60|^C61|^C62|^C63|^C64|^C65|^C66|^C67|^C68|^C69|^C70|^C71|^C72|^C73|^C74|^C75|^C76|^C81|^C82|^C83|^C84|^C85|^C88|^C90|^C91|^C92|^C93|^C94|^C95|^C96|^C97", var)), var = as.name(code)),
               msld = interp(~max(grepl("^I850|^I859|^I864|^I982|^K704|^K711|^K721|^K729|^K765|^K766|^K767", var)), var = as.name(code)),
               metacanc = interp(~max(grepl("^C77|^C78|^C79|^C80", var)), var = as.name(code)),
               aids = interp(~max(grepl("^B20|^B21|^B22|^B24", var)), var = as.name(code))) %>%
    ungroup() %>%
    mutate(score = ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(mld == 1 & msld == 1, 0, 1) + diab * ifelse(diab == 1 & diabwc == 1, 0, 1) + diabwc * 2 + hp * 2 + rend * 2 + canc * ifelse(canc == 1 & metacanc == 1, 0, 2) + msld * 3 + metacanc * 6 + aids * 6) %>%
    mutate(index = cut(score, breaks = c(0, 1, 2, Inf), labels = c("0", "1", "2+"), right = FALSE))

  # factorise comorbidities if requested
  if (factorise == TRUE) {
    cs <- cs %>%
      mutate_at(c("ami", "chf", "pvd", "cevd", "dementia", "copd", "rheumd", "pud", "mld", "diab", "diabwc", "hp", "rend", "canc", "msld", "metacanc", "aids"), function(x) factor(x, levels = 0:1, labels = c("No", "Yes")))
  }

  # label variables if requested and possible
  if (requireNamespace("Hmisc", quietly = TRUE) & labels == TRUE) {
    Hmisc::label(cs$ami) <- "Myocardial infarction"
    Hmisc::label(cs$chf) <- "Congestive heart failure"
    Hmisc::label(cs$pvd) <- "Peripheral vascular disease"
    Hmisc::label(cs$cevd) <- "Cerebrovascular disease"
    Hmisc::label(cs$dementia) <- "Dementia"
    Hmisc::label(cs$copd) <- "Chronic pulmonary disease"
    Hmisc::label(cs$rheumd) <- "Rheumatic disease"
    Hmisc::label(cs$pud) <- "Peptic ulcer disease"
    Hmisc::label(cs$mld) <- "Mild liver disease"
    Hmisc::label(cs$diab) <- "Diabetes without chronic complication"
    Hmisc::label(cs$diabwc) <- "Diabetes with chronic complication"
    Hmisc::label(cs$hp) <- "Hemiplegia or paraplegia"
    Hmisc::label(cs$rend) <- "Renal disease"
    Hmisc::label(cs$canc) <- "Any malignancy"
    Hmisc::label(cs$msld) <- "Moderate or severe liver disease"
    Hmisc::label(cs$metacanc) <- "Metastatic solid tumor"
    Hmisc::label(cs$aids) <- "AIDS/HIV"
    Hmisc::label(cs$score) <- "Weighted Charlson score"
    Hmisc::label(cs$index) <- "Grouped Charlson index"
  } else {
    if (!requireNamespace("Hmisc", quietly = TRUE) & labels == TRUE) {
      warning("Impossible to label variables without the Hmisc package. Install Hmisc with install.packages(\"Hmisc\").")
    }
  }

  # return a data frame
  return(cs)
}
