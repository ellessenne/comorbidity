#' @title Compute comorbidity scores.
#'
#' @description Computes comorbidity scores such as the weighted Charlson score and the Elixhauser comorbidity score.
#'
#' @param x A tidy `data.frame` (or a `data.table`; `tibble`s are supported too) with one column containing an individual ID and a column containing all diagnostic codes.
#' Extra columns other than ID and codes are discarded.
#' Column names must be syntactically valid names, otherwise they are forced to be so by calling the [make.names()] function.
#' @param id Column of `x` containing the individual ID.
#' @param code Column of `x` containing diagnostic codes. Codes must be in upper case with no punctuation in order to be properly recognised.
#' @param score The comorbidity score to compute. Possible choices are the weighted Charlson score (`charlson`), the weighted (pre 2019 AHRQ) Elixhauser score (`elixhauser`), and the 2019 AHRQ weighted Elixhauser score (`elixhauser_ahrq`). Values are case-insensitive.
#' @param assign0 Apply a hierarchy of comorbidities. If `TRUE`, should a comorbidity be present in a patient with different degrees of severity, then the milder form will be assigned to 0 and therefore not counted. By doing this, a type of comorbidity is not counted more than once in each patient. In particular, the comorbidities that are affected by this argument are:
#' * "Mild liver disease" (`mld`) and "Moderate/severe liver disease" (`msld`) for the Charlson score;
#' * "Diabetes" (`diab`) and "Diabetes with complications" (`diabwc`) for the Charlson score;
#' * "Cancer" (`canc`) and "Metastatic solid tumour" (`metacanc`) for the Charlson score;
#' * "Hypertension, uncomplicated" (`hypunc`) and "Hypertension, complicated" (`hypc`) for the Elixhauser score;
#' * "Diabetes, uncomplicated" (`diabunc`) and "Diabetes, complicated" (`diabc`) for the Elixhauser score;
#' * "Solid tumour" (`solidtum`) and "Metastatic cancer" (`metacanc`) for the Elixhauser score.
#' 
#' Note: This argument has no effect on Elixhauser AHRQ as these choices are incorporated into AHRQ calculations. If using 'elixhauser_ahrq' it is recommended to specify assign0 = FALSE to avoid confusion.
#' @param icd The version of ICD coding to use. Possible choices are ICD-9-CM (`icd9`) or ICD-10 (`icd10`). Defaults to `icd10`, and values are case-insensitive.
#' Note: if 'elixhauser_ahrq' is selected, icd must equal 'icd10'.
#' @param factorise Return comorbidities as factors rather than numeric, where (1 = presence of comorbidity, 0 = otherwise). Defaults to `FALSE`.
#' @param labelled Attach labels to each comorbidity, compatible with the RStudio viewer via the [utils::View()] function. Defaults to `TRUE`.
#' @param tidy.codes Tidy diagnostic codes? If `TRUE`, all codes are converted to upper case and all non-alphanumeric characters are removed using the regular expression \code{[^[:alnum:]]}. Defaults to `TRUE`.
#' @param drg Column of `x` that contains DRG codes associated with the encounter. Defaults to `NULL` but must be specified if score = 'elixhauser_ahrq'.
#' @param icd_rank Column of `x` that contains the rank or position of DRG codes. Defaults to `NULL` but must be specified if score = 'elixhauser_ahrq'.
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
#' For AHRQ Elixhauser (elixhauser_ahrq), the dataset contains the same variables as 'Elixhauser' with the following exceptions:
#'  * Comorbidity columns follow AHRQ's abbreviation formatting.
#'  * In place of `hypunc` and `hypc`, those measures are combined to form `HTN_C`
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
#' @references _Healthcare Cost and Utilization Project. Elixhauser Comorbidity Software Version 3.7_ Available at https://www.hcup-us.ahrq.gov/toolssoftware/comorbidity/comorbidity.jsp 
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

comorbidity <- function(x, id, code, score, assign0, icd = "icd10", factorise = FALSE, labelled = TRUE, tidy.codes = TRUE, drg=NULL, icd_rank=NULL) {
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # x must be a data.frame (or a data.table)
  checkmate::assert_true(all(class(x) %in% c("data.frame", "data.table", "tbl", "tbl_df")), add = arg_checks)
  # id, code, score, icd must be a single string value
  checkmate::assert_string(id, add = arg_checks)
  checkmate::assert_string(code, add = arg_checks)
  checkmate::assert_string(score, add = arg_checks)
  checkmate::assert_string(icd, add = arg_checks)
  # score must be charlson, elixhauser, elixhauser_ahrq; case insensitive
  score <- tolower(score)
  checkmate::assert_choice(score, choices = c("charlson", "elixhauser",
                                              "elixhauser_ahrq"), add = arg_checks)
  # icd must be icd9, icd10; case insensitive
  icd <- tolower(icd)
  checkmate::assert_choice(icd, choices = c("icd9", "icd10"), add = arg_checks)
  # assign0, factorise, labelled, tidy.codes, parallel must be a single boolean value
  checkmate::assert_logical(assign0, len = 1, add = arg_checks)
  checkmate::assert_logical(factorise, len = 1, add = arg_checks)
  checkmate::assert_logical(labelled, len = 1, add = arg_checks)
  checkmate::assert_logical(tidy.codes, len = 1, add = arg_checks)
  # drg and icd_rank must be supplied when score='elixhauser_ahrq'
  checkmate::assert_true(
    (score=='elixhauser_ahrq' & !is.null(drg) & !is.null(icd_rank)) | 
      (score!='elixhauser_ahrq' & is.null(drg) & is.null(icd_rank)),
    add = arg_checks
  )
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

  ### Extract regex for internal use
  regex <- lofregex[[score]][[icd]]
  
  ### Extract SAS DRGS
  if (!is.null(drg)) {
    # Remove first-rank ICD (D473 codes to "NONE")
    x[x[[icd_rank]]==1,code] = "D473"

    
    # Get number-group key-value pairs
    reverse_lofmsdrg = unstack(stack(lofmsdrg), form=ind~values)
    
    # Drop DRG leading zeros, convert to character
    all_drgs = as.numeric(x[[drg]])
    all_drgs = as.character(all_drgs)
    
    # Get list of SAS drg flags
    drg_flags = reverse_lofmsdrg[all_drgs]
    names(drg_flags) = x[[id]]
    drg_flags = drg_flags[unique(names(drg_flags))]
    drg_mask = !unlist(lapply(drg_flags, is.null))
    drg_flags = drg_flags[drg_mask]
  }

  ### Subset only 'id' and 'code' columns
  if (data.table::is.data.table(x)) {
    x <- x[, c(id, code), with = FALSE]
  } else {
    x <- x[, c(id, code)]
  }

  ## Turn x into a DT
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
  x <- data.table::dcast.data.table(
    xin, stats::as.formula(paste(id, "~ ind")), fill = 0)
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
  } else if (score == "elixhauser") {
    x$score <- with(x, chf + carit + valv + pcd + pvd + hypunc * ifelse(hypc == 1 & assign0, 0, 1) + hypc + para + ond + cpd + diabunc * ifelse(diabc == 1 & assign0, 0, 1) + diabc + hypothy + rf + ld + pud + aids + lymph + metacanc + solidtum * ifelse(metacanc == 1 & assign0, 0, 1) + rheumd + coag + obes + wloss + fed + blane + dane + alcohol + drug + psycho + depre)
    x$index <- with(x, cut(score, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    x$wscore_ahrq <- with(x, chf * 9 + carit * 0 + valv * 0 + pcd * 6 + pvd * 3 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * (-1) + para * 5 + ond * 5 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * (-3) + hypothy * 0 + rf * 6 + ld * 4 + pud * 0 + aids * 0 + lymph * 6 + metacanc * 14 + solidtum * ifelse(metacanc == 1 & assign0, 0, 7) + rheumd * 0 + coag * 11 + obes * (-5) + wloss * 9 + fed * 11 + blane * (-3) + dane * (-2) + alcohol * (-1) + drug * (-7) + psycho * (-5) + depre * (-5))
    x$wscore_vw <- with(x, chf * 7 + carit * 5 + valv * (-1) + pcd * 4 + pvd * 2 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * 0 + para * 7 + ond * 6 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * 0 + hypothy * 0 + rf * 5 + ld * 11 + pud * 0 + aids * 0 + lymph * 9 + metacanc * 12 + solidtum * ifelse(metacanc == 1 & assign0, 0, 4) + rheumd * 0 + coag * 3 + obes * (-4) + wloss * 6 + fed * 5 + blane * (-2) + dane * (-2) + alcohol * 0 + drug * (-7) + psycho * 0 + depre * (-3))
    x$windex_ahrq <- with(x, cut(wscore_ahrq, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    x$windex_vw <- with(x, cut(wscore_vw, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
  } else {
    ### Turn internal DF into a DT
    data.table::setDT(x)
    
    # This section replicates the AHRQ Elixhauser Comorbidity Software v3.7 
    # https://www.hcup-us.ahrq.gov/toolssoftware/comorbidity/comorbidity.jsp
    # /*******************************************/
    # /* Initialize Hypertension, CHF, and Renal */
    # /* Comorbidity flags to 1 using the detail */
    # /* hypertension flags.                     */
    # /*******************************************/
    # IF HTNPREG_  THEN HTNCX = 1;
    x[HTNPREG==1, HTNCX := 1]

    # IF HTNWOCHF_ THEN HTNCX = 1;
    x[HTNWOCHF==1, HTNCX := 1]

    # IF HTNWCHF_  THEN DO;
    #   HTNCX    = 1;
    #   CHF      = 1;
    x[HTNWCHF==1, c('HTNCX', 'CHF') := 1]
    # END;

    # IF HRENWORF_ THEN HTNCX = 1;
    x[HRENWORF==1, HTNCX := 1]

    # IF HRENWRF_  THEN DO;
    #   HTNCX    = 1;
    #   RENLFAIL = 1;
    x[HRENWRF==1, c('HTNCX', 'RENLFAIL') := 1]
    # END;

    # IF HHRWOHRF_ THEN HTNCX = 1;
    x[HHRWOHRF==1, HTNCX := 1]

    # IF HHRWCHF_  THEN DO;
    # HTNCX    = 1;
    # CHF      = 1;
    # END;
    x[HHRWCHF==1, c('HTNCX', 'CHF') := 1]

    # IF HHRWRF_   THEN DO;
    # HTNCX    = 1;
    # RENLFAIL = 1;
    # END;
    x[HHRWRF==1, c('HTNCX', 'RENLFAIL') := 1]

    # IF HHRWHRF_  THEN DO;
    # HTNCX    = 1;
    # CHF      = 1;
    # RENLFAIL = 1;
    # END;
    x[HHRWHRF==1, c('HTNCX', 'CHF', 'RENLFAIL') := 1]

    # IF OHTNPREG_ THEN HTNCX = 1;
    x[OHTNPREG==1, HTNCX := 1]

    #
    #
    #   /*********************************************************/
    #   /* Set up code to only count the more severe comorbidity */
    #   /*********************************************************/
    #   IF HTNCX = 1 THEN HTN = 0 ;
    x[HTNCX==1, HTN := 0]

    #   IF METS = 1 THEN TUMOR = 0 ;
    x[METS==1, TUMOR := 0]

    #   IF DMCX = 1 THEN DM = 0 ;
    x[DMCX==1, DM := 0]

    #
    #     /******************************************************/
    #     /* Examine DRG and set flags to identify a particular */
    #     /* DRG group                                          */
    #     /******************************************************/
    #     IF PUT(DRG,CARDDRG.)  = 'YES' THEN CARDFLG  = 1;
    #     IF PUT(DRG,PERIDRG.)  = 'YES' THEN PERIFLG  = 1;
    #     IF PUT(DRG,CEREDRG.)  = 'YES' THEN CEREFLG  = 1;
    #     IF PUT(DRG,NERVDRG.)  = 'YES' THEN NERVFLG  = 1;
    #     IF PUT(DRG,PULMDRG.)  = 'YES' THEN PULMFLG  = 1;
    #     IF PUT(DRG,DIABDRG.)  = 'YES' THEN DIABFLG  = 1;
    #     IF PUT(DRG,HYPODRG.)  = 'YES' THEN HYPOFLG  = 1;
    #     IF PUT(DRG,RENALDRG.) = 'YES' THEN RENALFLG = 1;
    #     IF PUT(DRG,RENFDRG.)  = 'YES' THEN RENFFLG  = 1;
    #     IF PUT(DRG,LIVERDRG.) = 'YES' THEN LIVERFLG = 1;
    #     IF PUT(DRG,ULCEDRG.)  = 'YES' THEN ULCEFLG  = 1;
    #     IF PUT(DRG,HIVDRG.)   = 'YES' THEN HIVFLG   = 1;
    #     IF PUT(DRG,LEUKDRG.)  = 'YES' THEN LEUKFLG  = 1;
    #     IF PUT(DRG,CANCDRG.)  = 'YES' THEN CANCFLG  = 1;
    #     IF PUT(DRG,ARTHDRG.)  = 'YES' THEN ARTHFLG  = 1;
    #     IF PUT(DRG,NUTRDRG.)  = 'YES' THEN NUTRFLG  = 1;
    #     IF PUT(DRG,ANEMDRG.)  = 'YES' THEN ANEMFLG  = 1;
    #     IF PUT(DRG,ALCDRG.)   = 'YES' THEN ALCFLG   = 1;
    #     IF PUT(DRG,HTNCXDRG.) = 'YES' THEN HTNCXFLG = 1;
    #     IF PUT(DRG,HTNDRG.)   = 'YES' THEN HTNFLG   = 1;
    #     IF PUT(DRG,COAGDRG.)  = 'YES' THEN COAGFLG  = 1;
    #     IF PUT(DRG,PSYDRG.)   = 'YES' THEN PSYFLG   = 1;
    #     IF PUT(DRG,OBESEDRG.) = 'YES' THEN OBESEFLG = 1;
    #     IF PUT(DRG,DEPRSDRG.) = 'YES' THEN DEPRSFLG = 1;

    # drg_flags have ids as names and indicated drgs as values
    drg_df = lapply(drg_flags, function(x) (names(lofmsdrg) %in% x)*1)
    drg_df = matrix(unlist(drg_df), nrow=length(drg_df), byrow=T)
    drg_df = data.table::data.table(drg_df, drg_id=names(drg_flags))
    colnames(drg_df) = c(names(lofmsdrg), 'drg_id')
    # Coerce drg_df to class of x to ensure merge
    class(drg_df$drg_id) = class(x[[id]])
    # Merge with x by ID
    x = merge(x, drg_df, by.x=id, by.y='drg_id', sort=F, all.x=T)

    # Make NAs 0
    x[is.na(x)] = 0

    #
    #
    #       /************************************************************/
    #       /* Redefining comorbidities by eliminating the DRG directly */
    #       /* related to comorbidity, thus limiting the screens to     */
    #       /* principal diagnoses not directly related to comorbidity  */
    #       /* in question                                              */
    #       /************************************************************/
    #       IF CHF   	AND CARDFLG  				THEN CHF 		= 0;
    x[CHF==1 & CARDDRG==1, CHF := 0]

    #       IF VALVE 	AND CARDFLG   				THEN VALVE 		= 0;
    x[VALVE==1 & CARDDRG==1, VALVE := 0]

    #       IF PULMCIRC  AND (CARDFLG OR PULMFLG ) 	THEN PULMCIRC 	= 0;
    x[PULMCIRC==1 & (CARDDRG==1 | PULMDRG==1), PULMCIRC := 0]

    #       IF PERIVASC  AND PERIFLG 				THEN PERIVASC 	= 0;
    x[PERIVASC==1 & PERIDRG==1, PERIVASC := 0]

    #       IF HTN 		AND HTNFLG 					THEN HTN 		= 0;
    x[HTN==1 & HTNDRG==1, HTN := 0] 

    #
    #         /**********************************************************/
    #         /* Apply DRG Exclusions to Hypertension Complicated, Con- */
    #         /* gestive Heart Failure, and Renal Failure comorbidities */
    #         /* using the detailed hypertension flags created above.   */
    #         /**********************************************************/
    #         IF HTNCX     AND HTNCXFLG THEN HTNCX = 0  ;
    x[HTNCX==1 & HTNCXDRG==1, HTNCX := 0] 

    #         IF HTNPREG_  AND HTNCXFLG THEN HTNCX = 0;
    x[HTNPREG==1 & HTNCXDRG==1, HTNCX := 0] 

    #         IF HTNWOCHF_ AND (HTNCXFLG OR CARDFLG) THEN HTNCX = 0;
    x[HTNWOCHF==1 & (HTNCXDRG==1 | CARDDRG==1), HTNCX := 0]

    #         IF HTNWCHF_  THEN DO;
    #           IF HTNCXFLG THEN HTNCX  = 0;
    x[HTNWCHF==1 & HTNCXDRG==1, HTNCX := 0] 

    #           IF CARDFLG THEN DO;
    #             HTNCX = 0;
    x[HTNWCHF==1 & CARDDRG==1, HTNCX := 0] 
    #             CHF   = 0;
    x[HTNWCHF==1 & CARDDRG==1, CHF := 0]

    #           END;
    #         END;

    #         IF HRENWORF_ AND (HTNCXFLG OR RENALFLG) THEN HTNCX = 0;
    x[HRENWORF==1 & (HTNCXDRG==1 | RENALDRG==1), HTNCX := 0]

    #         IF HRENWRF_  THEN DO;
    #           IF HTNCXFLG THEN HTNCX = 0;
    x[HRENWRF==1 & HTNCXDRG==1, HTNCX := 0]

    #           IF RENALFLG THEN DO;
    #             HTNCX    = 0;
    #             RENLFAIL = 0;
    x[HRENWRF==1 & RENALDRG==1, c('HTNCX', 'RENLFAIL') := 0] 

    #           END;
    #         END;

    #         IF HHRWOHRF_ AND (HTNCXFLG OR CARDFLG OR RENALFLG) THEN HTNCX = 0;
    x[HHRWOHRF==1 & (HTNCXDRG==1 | CARDDRG==1 | RENALDRG==1), HTNCX := 0] 

    #         IF HHRWCHF_ THEN DO;
    #           IF HTNCXFLG THEN HTNCX = 0;
    x[HHRWCHF==1 & HTNCXDRG==1, HTNCX := 0] 

    #             IF CARDFLG THEN DO;
    #               HTNCX = 0;
    #               CHF   = 0;
    x[HHRWCHF==1 & CARDDRG==1, c('HTNCX', 'CHF') := 0]

    #             END;
    #         IF RENALFLG THEN HTNCX = 0;
    x[HHRWCHF==1 & RENALDRG==1, HTNCX := 0] 

    #         END;


    #         IF HHRWRF_ THEN DO;
    #           IF HTNCXFLG OR CARDFLG THEN HTNCX = 0;
    x[HHRWRF==1 & (HTNCXDRG==1 | CARDDRG==1), HTNCX := 0] 

    #           IF RENALFLG THEN DO;
    #             HTNCX    = 0;
    #             RENLFAIL = 0;
    x[HHRWRF==1 & RENALDRG==1, c('HTNCX', 'RENLFAIL') := 0] 

    #           END;
    #         END;

    #         IF HHRWHRF_ THEN DO;
    #           IF HTNCXFLG THEN HTNCX = 0;
    x[HHRWHRF==1 & HTNCXDRG==1, HTNCX := 0] 

    #           IF CARDFLG THEN DO;
    #             HTNCX = 0;
    #             CHF   = 0;
    x[HHRWHRF==1 & CARDDRG==1, c('HTNCX', 'CHF') := 0] 

    #           END;
    #           IF RENALFLG THEN DO;
    #           HTNCX    = 0;
    #           RENLFAIL = 0;
    x[HHRWHRF==1 & RENALDRG==1, c('HTNCX', 'RENLFAIL') := 0] 

    #           END;
    #         END;
    #         IF OHTNPREG_ AND (HTNCXFLG OR CARDFLG OR RENALFLG) THEN HTNCX = 0;
    x[OHTNPREG==1 & (HTNCXDRG==1 | CARDDRG==1 | RENALDRG==1), HTNCX := 0] 

    #
    #         IF NEURO AND NERVFLG THEN NEURO = 0;
    x[NEURO==1 & NERVDRG==1, NEURO := 0] 

    #         IF CHRNLUNG AND PULMFLG THEN CHRNLUNG = 0;
    x[CHRNLUNG==1 & PULMDRG==1, CHRNLUNG := 0] 

    #         IF DM AND DIABFLG THEN DM = 0;
    x[DM==1 & DIABDRG==1, DM := 0] 

    #         IF DMCX AND DIABFLG THEN DMCX = 0 ;
    x[DMCX==1 & DIABDRG==1, DMCX := 0] 

    #         IF HYPOTHY AND HYPOFLG THEN HYPOTHY = 0;
    x[HYPOTHY==1 & HYPODRG==1, HYPOTHY := 0] 

    #         IF RENLFAIL AND RENFFLG THEN   RENLFAIL = 0;
    x[RENLFAIL==1 & RENFDRG==1, RENLFAIL := 0] 

    #         IF LIVER AND LIVERFLG THEN LIVER = 0;
    x[LIVER==1 & LIVERDRG==1, LIVER := 0] 

    #         IF ULCER AND ULCEFLG THEN  ULCER = 0;
    x[ULCER==1 & ULCEDRG==1, ULCER := 0] 

    #         IF AIDS AND HIVFLG THEN AIDS = 0;
    x[AIDS==1 & HIVDRG==1, AIDS := 0] 

    #         IF LYMPH AND LEUKFLG THEN LYMPH = 0;
    x[LYMPH==1 & LEUKDRG==1, LYMPH := 0] 

    #         IF METS AND CANCFLG THEN METS = 0;
    x[METS==1 & CANCDRG==1, METS := 0] 

    #         IF TUMOR AND CANCFLG THEN TUMOR = 0;
    x[TUMOR==1 & CANCDRG==1, TUMOR := 0] 

    #         IF ARTH AND ARTHFLG THEN ARTH = 0;
    x[ARTH==1 & ARTHDRG==1, ARTH := 0] 

    #         IF COAG AND COAGFLG THEN COAG = 0;
    x[COAG==1 & COAGDRG==1, COAG := 0] 

    #         IF OBESE AND (NUTRFLG OR OBESEFLG) THEN  OBESE = 0;
    x[OBESE==1 & (NUTRDRG==1 | OBESEDRG==1), OBESE := 0] 

    #         IF WGHTLOSS AND NUTRFLG THEN WGHTLOSS = 0;
    x[WGHTLOSS==1 & NUTRDRG==1, WGHTLOSS := 0] 

    #         IF LYTES AND NUTRFLG THEN LYTES = 0;
    x[LYTES==1 & NUTRDRG==1, LYTES := 0] 

    #         IF BLDLOSS AND ANEMFLG THEN BLDLOSS = 0;
    x[BLDLOSS==1 & ANEMDRG==1, BLDLOSS := 0] 

    #         IF ANEMDEF AND ANEMFLG THEN ANEMDEF = 0;
    x[ANEMDEF==1 & ANEMDRG==1, ANEMDEF := 0] 

    #         IF ALCOHOL AND ALCFLG THEN ALCOHOL = 0;
    x[ALCOHOL==1 & ALCDRG==1, ALCOHOL := 0] 

    #         IF DRUG AND ALCFLG THEN DRUG = 0;
    x[DRUG==1 & ALCDRG==1, DRUG := 0] 

    #         IF PSYCH AND PSYFLG THEN PSYCH = 0;
    x[PSYCH==1 & PSYDRG==1, PSYCH := 0] 

    #         IF DEPRESS AND DEPRSFLG THEN DEPRESS = 0;
    x[DEPRESS==1 & DEPRSDRG==1, DEPRESS := 0] 

    #         IF PARA AND CEREFLG THEN PARA = 0;
    x[PARA==1 & CEREDRG==1, PARA := 0] 

    #
    #           /*************************************/
    #           /*  Combine HTN and HTNCX into HTN_C */
    #           /*************************************/
    #           ATTRIB HTN_C LENGTH=3 LABEL='Hypertension';
    #
    #           IF HTN=1 OR HTNCX=1 THEN HTN_C=1;
    #           ELSE HTN_C=0;
    x$HTN_C = ifelse(x$HTN==1 | x$HTNCX==1, 1, 0)

    # Rename columns to comorbidity package conventions for calculations
    old_names = c("CHF", "VALVE", "PULMCIRC", "PERIVASC", "HTN", "HTNCX", "PARA",
            "NEURO", "CHRNLUNG", "DM", "DMCX", "HYPOTHY", "RENLFAIL", "LIVER",
            "ULCER", "AIDS", "LYMPH", "METS", "TUMOR", "ARTH", "COAG", "OBESE",
            "WGHTLOSS", "LYTES", "BLDLOSS", "ANEMDEF", "ALCOHOL", "DRUG",
            "PSYCH", "DEPRESS")
    new_names = c("chf", "valv", "pcd", "pvd", "hypunc", "hypc", "para", "ond", "cpd",
            "diabunc", "diabc", "hypothy", "rf", "ld", "pud", "aids", "lymph",
            "metacanc", "solidtum", "rheumd", "coag", "obes", "wloss", "fed",
            "blane", "dane", "alcohol", "drug", "psycho", "depre")
    x <- data.table::setnames(x, old=old_names, new=new_names)

    # Same computations as "elixhauser" (except carit removed)
    x$score <- with(x, chf + valv + pcd + pvd + hypunc * ifelse(hypc == 1 & assign0, 0, 1) + hypc + para + ond + cpd + diabunc * ifelse(diabc == 1 & assign0, 0, 1) + diabc + hypothy + rf + ld + pud + aids + lymph + metacanc + solidtum * ifelse(metacanc == 1 & assign0, 0, 1) + rheumd + coag + obes + wloss + fed + blane + dane + alcohol + drug + psycho + depre)
    x$index <- with(x, cut(score, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    x$wscore_ahrq <- with(x, chf * 9 + valv * 0 + pcd * 6 + pvd * 3 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * (-1) + para * 5 + ond * 5 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * (-3) + hypothy * 0 + rf * 6 + ld * 4 + pud * 0 + aids * 0 + lymph * 6 + metacanc * 14 + solidtum * ifelse(metacanc == 1 & assign0, 0, 7) + rheumd * 0 + coag * 11 + obes * (-5) + wloss * 9 + fed * 11 + blane * (-3) + dane * (-2) + alcohol * (-1) + drug * (-7) + psycho * (-5) + depre * (-5))
    x$wscore_vw <- with(x, chf * 7 + valv * (-1) + pcd * 4 + pvd * 2 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * 0 + para * 7 + ond * 6 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0, 0, 0) + diabc * 0 + hypothy * 0 + rf * 5 + ld * 11 + pud * 0 + aids * 0 + lymph * 9 + metacanc * 12 + solidtum * ifelse(metacanc == 1 & assign0, 0, 4) + rheumd * 0 + coag * 3 + obes * (-4) + wloss * 6 + fed * 5 + blane * (-2) + dane * (-2) + alcohol * 0 + drug * (-7) + psycho * 0 + depre * (-3))
    x$windex_ahrq <- with(x, cut(wscore_ahrq, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    x$windex_vw <- with(x, cut(wscore_vw, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
    
    # Return AHRQ vars in SAS format:
    x <- data.table::setnames(x, old=new_names, new=old_names)
    
    ### Turn internal DT into a DF
    data.table::setDF(x)
    
    # Keep only relevant vars 
    x <- x[c(id, "CHF", "VALVE", "PULMCIRC", "PERIVASC", "PARA",
             "NEURO", "CHRNLUNG", "DM", "DMCX", "HYPOTHY", "RENLFAIL", "LIVER",
             "ULCER", "AIDS", "LYMPH", "METS", "TUMOR", "ARTH", "COAG", "OBESE",
             "WGHTLOSS", "LYTES", "BLDLOSS", "ANEMDEF", "ALCOHOL", "DRUG",
             "PSYCH", "DEPRESS", "HTN_C",
             'score', 'index', 'wscore_ahrq', 'wscore_vw', 'windex_ahrq',
             'windex_vw')]
    
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

