# All AHRQ SAS conversion functions stored here

################################################################################
################################################################################
################################################################################
# 2020

#' @export
#' @keywords internal

get_ahrq_2020 <- function(x, id, code, assign0, drg, icd_rank) {
  ### Extract regex for internal use
  regex <- lofregex[['elixhauser_ahrq_2020']][['icd10']]

  ### Extract SAS DRGS and make sure id is not factor
  # make sure there are no factors (it will break when combining drgs)
  if (any(lapply(x, class)=='factor')) {
    x <- data.frame(
      lapply(x, function(j) {
        if(class(j)=='factor') {
          as.character(j)
        } else {j}
      }),
      stringsAsFactors = F
    )
  }

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

  # Return the dataframe
  x
}

################################################################################
################################################################################
################################################################################
# 2021

#' @export
#' @keywords internal

get_ahrq_2021 = function(
  df,
  patient_id = NULL,
  icd_code = NULL,
  icd_seq = NULL,
  poa_code = NULL,
  year = NULL,
  quarter = NULL,
  icd10cm_vers = NULL, # If NULL, vers derived from year/quarter columns
  return_n_unique = T # For N comorbidity vs. N ICD-Codes per comorbdiity
) {

  # Set poa value based on whether poa_code is supplied
  if (is.null(poa_code)) {
    poa = F
  } else {
    poa = T
  }

  # Make df into dt
  dt = data.table::data.table(df)

  # rename cols
  new_col_names = c()
  new_col_names[patient_id] = 'id'
  new_col_names[icd_code] = 'code'
  new_col_names[icd_seq] = 'icd_seq'
  new_col_names[poa_code] = 'poa_code'
  new_col_names[year] = 'year'
  new_col_names[quarter] = 'quarter'

  data.table::setnames(dt, names(new_col_names), new_col_names,
                       skip_absent = T)

  # Start AHRQ, SAS code in comments as reference
  # get_ahrq_2021-specific comments begin with "# !R":
  #
  # !R: Code is implemented differently in R, not all SAS lines will have a 1:1
  # corresponding R counterpart. SAS code included only as reference

  # /******************************************************************/
  # /* Title:       CREATION OF COMORBIDITY VARIABLES                 */
  # /*              ICD-10-CM COMORBIDITY SOFTWARE,                   */
  # /*                       VERSION 2021.1                           */
  # /*                                                                */
  # /* PROGRAM:     Comorb_ICD10CM_Analy_v2021-1.sas                  */
  # /*                                                                */
  # /* Description: Creates comorbidity variables based on the        */
  # /*              secondary diagnoses. Identification of some       */
  # /*              comorbidities is dependent on the diagnosis being */
  # /*              present on admission. Valid through FY2021        */
  # /*              (09/30/21).                                       */
  # /*                                                                */
  # /* Note:        Please specify below if diagnosis present on      */
  # /*              admission (POA) indicators are available in your  */
  # /*              data. If POA is not available, comorbidity flags  */
  # /*              that require POA will be set to missing.          */
  # /******************************************************************/
  #

  # !R: SAS Macro definitions lines omitted

  #    /*****************************************/
  #    /*    Establish the ICD-10-CM Version    */
  #    /* This will default to the last version */
  #    /* for discharges outside of coding      */
  #    /* updates.                              */
  #    /*****************************************/

  # !R: ICD-10-CM Version derived from Year/Quarter column unless specified
  # manually in `icd10cm_vers` param

  #    attrib ICDVER length=3 label='ICD-10-CM VERSION';
  #
  #    ICDVER = 0;
  #
  #    if      (YEAR in (2015) and DQTR in (4))     then ICDVER = 33;
  #    else if (YEAR in (2016) and DQTR in (1,2,3)) then ICDVER = 33;
  #    else if (YEAR in (2016) and DQTR in (4))     then ICDVER = 34;
  #    else if (YEAR in (2017) and DQTR in (1,2,3)) then ICDVER = 34;
  #    else if (YEAR in (2017) and DQTR in (4))     then ICDVER = 35;
  #    else if (YEAR in (2018) and DQTR in (1,2,3)) then ICDVER = 35;
  #    else if (YEAR in (2018) and DQTR in (4))     then ICDVER = 36;
  #    else if (YEAR in (2019) and DQTR in (1,2,3)) then ICDVER = 36;
  #    else if (YEAR in (2019) and DQTR in (4))     then ICDVER = 37;
  #    else if (YEAR in (2020) and DQTR in (1,2,3)) then ICDVER = 37;
  #    else if (YEAR in (2020) and DQTR in (4))     then ICDVER = 38;
  #    else if (YEAR in (2021) and DQTR in (1,2,3)) then ICDVER = 38;
  #    else                                              ICDVER = 38;

  if (is.null(icd10cm_vers)) {
    dt[, ICDVER := 38] # !R: Default value
    dt[year == 2015 & quarter == 4,
       ICDVER := 33]
    dt[year == 2016 & quarter < 4,
       ICDVER := 33]
    dt[year == 2016 & quarter == 4,
       ICDVER := 34]
    dt[year == 2017 & quarter < 4,
       ICDVER := 34]
    dt[year == 2017 & quarter == 4,
       ICDVER := 35]
    dt[year == 2018 & quarter < 4,
       ICDVER := 35]
    dt[year == 2018 & quarter == 4,
       ICDVER := 36]
    dt[year == 2019 & quarter < 4,
       ICDVER := 36]
    dt[year == 2019 & quarter == 4,
       ICDVER := 37]
    dt[year == 2020 & quarter < 4,
       ICDVER := 37]
  } else {
    dt[, ICDVER := icd10cm_vers]
  }

  #
  #    /********************************************/
  #    /* Establish lengths for all comorbidity    */
  #    /* flags.                                   */
  #    /********************************************/

  # !R: Unncessary SAS code omitted

  #
  #    /********************************************/
  #    /* Create diagnosis and comorbidity arrays  */
  #    /* for all comorbidity flags.               */
  #    /********************************************/

  # !R: Unncessary SAS code omitted

  #    ARRAY VALANYPOA  (20) $13 A1-A20
  # ("AIDS" "ALCOHOL" "ARTH" "LUNG_CHRONIC"  "DEMENTIA" "DEPRESS" "DIAB_UNCX" "DIAB_CX"
  # "DRUG_ABUSE"  "HTN_UNCX" "HTN_CX" "THYROID_HYPO" "THYROID_OTH" "CANCER_LYMPH" "CANCER_LEUK"
  # "CANCER_METS" "OBESE" "PERIVASC" "CANCER_SOLID" "CANCER_NSITU");

  VALANYPOA = c(
    'AIDS',
    'ALCOHOL',
    'ARTH',
    'LUNG_CHRONIC',
    'DEMENTIA',
    'DEPRESS',
    'DIAB_UNCX',
    'DIAB_CX',
    'DRUG_ABUSE',
    'HTN_UNCX',
    'HTN_CX',
    'THYROID_HYPO',
    'THYROID_OTH',
    'CANCER_LYMPH',
    'CANCER_LEUK',
    'CANCER_METS',
    'OBESE',
    'PERIVASC',
    'CANCER_SOLID',
    'CANCER_NSITU'
  )

  #
  #    /****************************************************/
  #    /* If POA flags are available, create POA, exempt,  */
  #    /* and value arrays.                                */
  #    /****************************************************/
  #    %if &POA. = 1 %then %do;
  #    ARRAY EXEMPTPOA (&NUMDX)  EXEMPTPOA1 - EXEMPTPOA&NUMDX;
  #
  #    ARRAY DXPOA     (&NUMDX) $  DXPOA1 - DXPOA&NUMDX;
  #
  #    ARRAY VALPOA    (19) $13 B1-B19
  #                        ("ANEMDEF"     "BLDLOSS"      "CHF"        "COAG"       "LIVER_MLD"  "LIVER_SEV"
  #                         "NEURO_MOVT"  "NEURO_SEIZ"   "NEURO_OTH"  "PARALYSIS"  "PSYCHOSES"  "PULMCIRC"   "RENLFL_MOD"
  #                         "RENLFL_SEV"  "ULCER_PEPTIC" "WGHTLOSS"   "CBVD_POA"   "CBVD_SQLA"  "VALVE");
  #    %end;

  # !R: These variables require POA status AND require "Y" or "W" POA (present)
  # !R: Note CBVD_POA requires POA status but requires "N" or "U" (not present)
  VALPOA = c(
    'ANEMDEF',
    'BLDLOSS',
    'CHF',
    'COAG',
    'LIVER_MLD',
    'LIVER_SEV',
    'NEURO_MOVT',
    'NEURO_SEIZ',
    'NEURO_OTH',
    'PARALYSIS',
    'PSYCHOSES',
    'PULMCIRC',
    'RENLFL_MOD',
    'RENLFL_SEV',
    'ULCER_PEPTIC',
    'WGHTLOSS',
    'CBVD_POA',
    'CBVD_SQLA',
    'VALVE'
  )


  #    /****************************************************/
  #    /* Initialize POA independent comorbidity flags to  */
  #    /* zero.                                            */
  #    /****************************************************/
  #    DO I = 1 TO 20;
  #       COMANYPOA(I) = 0;
  #    END;
  #
  #    /****************************************************/
  #    /* IF POA flags are available, initialize POA       */
  #    /* dependent comorbidiy flags to zero. If POA flags */
  #    /* are not available, these fields will be default  */
  #    /* to missing.                                      */
  #    /****************************************************/

  if (poa) {
    #    %if &POA. = 1 %then %do;
    #    DO I = 1 TO 19;
    #       COMPOA(I) = 0;
    #    END;
    #    CBVD_NPOA   = 0;
    #    CBVD        = 0;
    #    EXEMPTPOA1  = 0;
    dt[, c('CBVD_NPOA', 'CBVD', 'EXEMPTPOA') := 0]
    #    %end;
  } else {
    #    %else %do;
    #    CBVD_NPOA   = .;
    #    CBVD        = .;
    dt[, c('CBVD_NPOA', 'CBVD') := NA]
    #    %end;
  }

  #
  #    /****************************************************/
  #    /* Examine each secondary diagnosis on a record and */
  #    /* assign comorbidity flags.                        */
  #    /* 1) Assign comorbidities which are neutral to POA */
  #    /*    reporting.                                    */
  #    /* 2) IF POA flags are available, assign            */
  #    /*    comorbidities that require a diagnosis be     */
  #    /*    present on admission and are not exempt from  */
  #    /*    POA reporting.                                */
  #    /* 3) IF POA flags are available, assign one        */
  #    /*    comorbidity that requires that the diagnosis  */
  #    /*    NOT be present admission.                     */
  #    /****************************************************/
  #    DO I = 2 TO MIN(I10_NDX, &NUMDX);
  #       IF DX(I) NE " " THEN DO;
  #
  #          DXVALUE = PUT(DX(I),COMFMT.);


  #
  #          /****************************************************/
  #          /*   Assign Comorbidities that are neutral to POA   */
  #          /****************************************************/
  #          DO J = 1 TO 20;
  #             IF DXVALUE = VALANYPOA(J)  THEN COMANYPOA(J) = 1;
  #          END;

  dt[icd_seq==1, code := ''] # !R: Omit 1st diagnosis
  dxvalues = Elixhauser2021Formats$ElixhauserAHRQ2021Map$comfmt
  # !R: !VALPOA
  for (i in names(dxvalues)[!names(dxvalues) %in% VALPOA]) {
    dt[, paste0(i) := as.numeric(code %in% dxvalues[[i]])]
  }

  #          IF DXVALUE = "DRUG_ABUSEPSYCHOSES"  THEN DRUG_ABUSE= 1;
  dt[DRUG_ABUSEPSYCHOSES==1, DRUG_ABUSE := 1]
  #          IF DXVALUE = "CHFHTN_CX"            THEN HTN_CX    = 1;
  dt[CHFHTN_CX==1, HTN_CX := 1]
  #          IF DXVALUE = "HTN_CXRENLFL_SEV"     THEN HTN_CX    = 1;
  dt[HTN_CXRENLFL_SEV==1, HTN_CX := 1]
  #          IF DXVALUE = "CHFHTN_CXRENLFL_SEV"  THEN HTN_CX    = 1;
  dt[CHFHTN_CXRENLFL_SEV==1, HTN_CX := 1]
  #          IF DXVALUE = "ALCOHOLLIVER_MLD"     THEN ALCOHOL   = 1;
  dt[ALCOHOLLIVER_MLD==1, ALCOHOL := 1]


  if (poa) {
    #          %if &POA. = 1 %then %do;
    #          /****************************************************/
    #          /* IF POA flags are available, assign comorbidities */
    #          /* requiring POA that are also not exempt from POA  */
    #          /* reporting.                                       */
    #          /****************************************************/
    #          EXEMPTPOA(I) = 0;
    #          IF (ICDVER = 38 AND PUT(DX(I),$poaxmpt_v38fmt.)='1') OR
    #             (ICDVER = 37 AND PUT(DX(I),$poaxmpt_v37fmt.)='1') OR
    #             (ICDVER = 36 AND PUT(DX(I),$poaxmpt_v36fmt.)='1') OR
    #             (ICDVER = 35 AND PUT(DX(I),$poaxmpt_v35fmt.)='1') OR
    #             (ICDVER = 34 AND PUT(DX(I),$poaxmpt_v34fmt.)='1') OR
    #             (ICDVER = 33 AND PUT(DX(I),$poaxmpt_v33fmt.)='1') THEN EXEMPTPOA(I) = 1;

    # !R: if icd10cm_vers = NULL, formats extracted from year/quarter (see above)
    dt[ICDVER == 33,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v33fmt)]
    dt[ICDVER == 34,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v34fmt)]
    dt[ICDVER == 35,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v35fmt)]
    dt[ICDVER == 36,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v36fmt)]
    dt[ICDVER == 37,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v37fmt)]
    dt[ICDVER == 38,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v38fmt)]

    #          /**** Flag record if diagnosis is POA exempt or requires POA and POA ****/
    #          /**** indicates present on admission (Y or W) ****/
    #          IF (EXEMPTPOA(I) = 1)  or (EXEMPTPOA(I) = 0 AND DXPOA(I) IN ("Y","W")) THEN DO;
    #             DO K = 1 TO 19;
    #                IF DXVALUE = VALPOA(K)  THEN COMPOA(K) = 1;
    #             END;
    # !R: VALPOA w/conditions
    for (i in VALPOA) {
      dt[EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W')),
         paste0(i) := as.numeric(code %in% dxvalues[[i]])]
    }

    #             IF DXVALUE = "DRUG_ABUSEPSYCHOSES" THEN PSYCHOSES  = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         DRUG_ABUSEPSYCHOSES==1,
       PSYCHOSES := 1]

    #             IF DXVALUE = "CHFHTN_CX"           THEN CHF        = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         CHFHTN_CX==1,
       CHF := 1]

    #             IF DXVALUE = "HTN_CXRENLFL_SEV"    THEN RENLFL_SEV = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         HTN_CXRENLFL_SEV==1,
       RENLFL_SEV := 1]

    #             IF DXVALUE = "CHFHTN_CXRENLFL_SEV" THEN DO;
    #                CHF        = 1;
    #                RENLFL_SEV = 1;
    #             END;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         CHFHTN_CXRENLFL_SEV==1,
       c('CHF', 'RENLFL_SEV') := 1]

    #             IF DXVALUE = "CBVD_SQLAPARALYSIS"  THEN DO;
    #                PARALYSIS = 1;
    #                CBVD_SQLA = 1;
    #             END;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         CBVD_SQLAPARALYSIS==1,
       c('PARALYSIS', 'CBVD_SQLA') := 1]

    #             IF DXVALUE = "ALCOHOLLIVER_MLD"    THEN LIVER_MLD = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         ALCOHOLLIVER_MLD==1,
       LIVER_MLD := 1]

    #          END;

    #          /****************************************************/
    #          /* IF POA flags are available, assign comorbidities */
    #          /* requiring that the diagnosis is not POA          */
    #          /****************************************************/
    #          IF (EXEMPTPOA(I) = 0 AND DXPOA(I) IN ("N","U")) THEN DO;
    #             IF DXVALUE = "CBVD_POA"  THEN CBVD_NPOA = 1;

    dt[EXEMPTPOA==0 & poa_code %in% c('N', 'U') &
         code %in% dxvalues$CBVD_POA,
       c('CBVD_NPOA') := 1]
  }
  #          END;
  #          %end;
  #       END;
  #    END;
  #

  #! R pivot_wider to get pre-exclusion assignments + IDs
  #! R make any NA -> 0
  for (i in names(dt)) {
    dt[is.na(get(i)), (i):=0]
  }

  to_pivot = c('id',
               Elixhauser2021Formats$ElixhauserAHRQ2021PreExclusion)
  # Remove columns in to_pivot that do not exist if poa=F
  to_pivot = to_pivot[to_pivot %in% colnames(dt)]
  dt = dt[, ..to_pivot]

  dt = dt[, lapply(.SD, sum), by=id,
          .SDcols = to_pivot[-1]]

  dt[, names(dt)[-1] := lapply(.SD, function(x) as.integer(x!=0)),
     .SDcols = names(dt)[-1]]

  #    /****************************************************/
  #    /* Implement exclusions for comorbidities that are  */
  #    /* neutral to POA.                                  */
  #    /****************************************************/
  #    IF DIAB_CX      = 1 then DIAB_UNCX   = 0;
  dt[DIAB_CX==1, DIAB_UNCX := 0]

  #    IF HTN_CX       = 1 then HTN_UNCX    = 0;
  dt[HTN_CX==1, HTN_UNCX := 0]

  #    IF CANCER_METS  = 1 THEN DO;
  #       CANCER_SOLID = 0;
  #       CANCER_NSITU = 0;
  dt[CANCER_METS==1, c('CANCER_SOLID', 'CANCER_NSITU') := 0]

  #    END;
  #    IF CANCER_SOLID = 1 then CANCER_NSITU = 0;
  dt[CANCER_SOLID==1, CANCER_NSITU := 0]
  #

  if (poa) {
    #    /****************************************************/
    #    /* IF POA flags are available, implement exclusions */
    #    /* for comorbidities requiring POA.                 */
    #    /****************************************************/
    #    %if &POA. = 1 %then %do;
    #    IF LIVER_SEV    = 1 then LIVER_MLD   = 0;
    dt[LIVER_SEV==1, LIVER_MLD := 0]

    #    IF RENLFL_SEV   = 1 then RENLFL_MOD  = 0;
    dt[RENLFL_SEV==1, RENLFL_MOD := 0]

    #    IF (CBVD_POA=1) or (CBVD_POA=0 and CBVD_NPOA=0 and CBVD_SQLA=1) then CBVD = 1;
    dt[(CBVD_POA==1) | (CBVD_POA==0 & CBVD_NPOA==0 & CBVD_SQLA==1),
       CBVD := 1]
  }
  #    %end;
  #
  # !R: Remainder of SAS code not relevant

  # !R: Get final comorbidities
  keep_vars = c('id',
                Elixhauser2021Formats$ElixhauserAHRQ2021Abbr)
  # Drop vars that don't exist if poa=T
  keep_vars = keep_vars[keep_vars %in% colnames(dt)]
  dt = dt[, ..keep_vars]

  # Compute total score
  dt[, score := rowSums(.SD),
     .SDcols = keep_vars[-1]]

  # Rename id back to user-specified
  data.table::setnames(dt, new_col_names, names(new_col_names),
                       skip_absent = T)

  # Return as data.frame
  as.data.frame(dt)
}

get_ahrq_2022 = function(
  df,
  patient_id = NULL,
  icd_code = NULL,
  icd_seq = NULL,
  poa_code = NULL,
  year = NULL,
  quarter = NULL,
  icd10cm_vers = NULL, # If NULL, vers derived from year/quarter columns
  return_n_unique = T # For N comorbidity vs. N ICD-Codes per comorbdiity
) {

  # Set poa value based on whether poa_code is supplied
  if (is.null(poa_code)) {
    poa = F
  } else {
    poa = T
  }

  # Make df into dt
  dt = data.table::data.table(df)

  # rename cols
  new_col_names = c()
  new_col_names[patient_id] = 'id'
  new_col_names[icd_code] = 'code'
  new_col_names[icd_seq] = 'icd_seq'
  new_col_names[poa_code] = 'poa_code'
  new_col_names[year] = 'year'
  new_col_names[quarter] = 'quarter'

  data.table::setnames(dt, names(new_col_names), new_col_names,
                       skip_absent = T)

  # Start AHRQ, SAS code in comments as reference
  # get_ahrq_2021-specific comments begin with "# !R":
  #
  # !R: Code is implemented differently in R, not all SAS lines will have a 1:1
  # corresponding R counterpart. SAS code included only as reference

  # /******************************************************************/
  #   /* Title:       ELIXHAUSER COMORBIDITY SOFTWARE REFINED           */
  #   /*              FOR ICD-10-CM MAPPING PROGRAM                     */
  #   /*                                                                */
  #   /* Program:     CMR_Mapping_Program_v2022-1.SAS                   */
  #   /*                                                                */
  #   /* Diagnoses:   v2022-1 is compatible with ICD-10-CM diagnosis    */
  #   /*              codes from October 2015 through September 2022.   */
  #   /*              ICD-10-CM codes should not include embedded       */
  #   /*              decimals (example: S0100XA, not S01.00XA).        */
  #   /*                                                                */
  #   /* Description: This SAS mapping program assigns the Elixhauser   */
  #   /*              comorbidity measures from ICD-10-CM secondary     */
  #   /*              diagnoses. Some comorbidities require additional  */
  #   /*              information on whether the diagnosis was present  */
  #   /*              on admission (POA). Please specify below if POA   */
  #   /*              indicators are available in your data. If POA     */
  #   /*              information is not available, comorbidities that  */
  #   /*              require POA will be set to missing.               */
  #   /*                                                                */
  #   /* Note:	    The SAS program CMR_Format_Program_v2022-1 must   */
  #   /*	            be run prior to running this mapping program.     */
  #   /*                                                                */
  #   /* Output:	    This program appends the comorbidity measures     */
  #   /*	            to the input SAS file.  The data elements start   */
  #   /*              with the 4-character prefix CMR_                  */
  #   /*                                                                */
  #   /******************************************************************/

  # !R: SAS Macro definitions lines omitted

  ###############################################################################################
  # The following block of SAS code is a copy of "CMR_Mapping_Program_v2022-1.sas" lines 100-124.
  ###############################################################################################
  # /*****************************************/
  #   /*    Establish the ICD-10-CM Version    */
  #   /* This will default to the last version */
  #   /* for discharges outside of coding      */
  #   /* updates.                              */
  #   /*****************************************/
  #   ATTRIB ICDVER LENGTH=3 LABEL='ICD-10-CM VERSION';
  #
  # ICDVER = 0;
  #
  # IF      (YEAR IN (2015) AND DQTR IN (4))     THEN ICDVER = 33;
  # ELSE IF (YEAR IN (2016) AND DQTR IN (1,2,3)) THEN ICDVER = 33;
  # ELSE IF (YEAR IN (2016) AND DQTR IN (4))     THEN ICDVER = 34;
  # ELSE IF (YEAR IN (2017) AND DQTR IN (1,2,3)) THEN ICDVER = 34;
  # ELSE IF (YEAR IN (2017) AND DQTR IN (4))     THEN ICDVER = 35;
  # ELSE IF (YEAR IN (2018) AND DQTR IN (1,2,3)) THEN ICDVER = 35;
  # ELSE IF (YEAR IN (2018) AND DQTR IN (4))     THEN ICDVER = 36;
  # ELSE IF (YEAR IN (2019) AND DQTR IN (1,2,3)) THEN ICDVER = 36;
  # ELSE IF (YEAR IN (2019) AND DQTR IN (4))     THEN ICDVER = 37;
  # ELSE IF (YEAR IN (2020) AND DQTR IN (1,2,3)) THEN ICDVER = 37;
  # ELSE IF (YEAR IN (2020) AND DQTR IN (4))     THEN ICDVER = 38;
  # ELSE IF (YEAR IN (2021) AND DQTR IN (1,2,3)) THEN ICDVER = 38;
  # ELSE IF (YEAR IN (2021) AND DQTR IN (4))     THEN ICDVER = 39;
  # ELSE IF (YEAR IN (2022) AND DQTR IN (1,2,3)) THEN ICDVER = 39;
  # ELSE                                              ICDVER = 39;

  if (is.null(icd10cm_vers)) {
    dt[, ICDVER := 39] # !R: Default value
    dt[year == 2015 & quarter == 4,
       ICDVER := 33]
    dt[year == 2016 & quarter < 4,
       ICDVER := 33]
    dt[year == 2016 & quarter == 4,
       ICDVER := 34]
    dt[year == 2017 & quarter < 4,
       ICDVER := 34]
    dt[year == 2017 & quarter == 4,
       ICDVER := 35]
    dt[year == 2018 & quarter < 4,
       ICDVER := 35]
    dt[year == 2018 & quarter == 4,
       ICDVER := 36]
    dt[year == 2019 & quarter < 4,
       ICDVER := 36]
    dt[year == 2019 & quarter == 4,
       ICDVER := 37]
    dt[year == 2020 & quarter < 4,
       ICDVER := 37]
    dt[year == 2020 & quarter == 4,
       ICDVER := 38]
    dt[year == 2021 & quarter < 4,
       ICDVER := 38]
  } else {
    dt[, ICDVER := icd10cm_vers]
  }

  #
  #    /********************************************/
  #    /* Establish lengths for all comorbidity    */
  #    /* flags.                                   */
  #    /********************************************/

  # !R: Unncessary SAS code omitted

  #
  #    /********************************************/
  #    /* Create diagnosis and comorbidity arrays  */
  #    /* for all comorbidity flags.               */
  #    /********************************************/

  # !R: Unncessary SAS code omitted

  ###############################################################################################
  # The following block of SAS code is a copy of "CMR_Mapping_Program_v2022-1.sas" lines 153-156.
  ###############################################################################################
  # ARRAY VALANYPOA  (20) $13 A1-A20
  # ("AIDS"        "ALCOHOL"   "AUTOIMMUNE"  "LUNG_CHRONIC"  "DEMENTIA"      "DEPRESS"       "DIAB_UNCX"     "DIAB_CX"
  #   "DRUG_ABUSE"  "HTN_UNCX"  "HTN_CX"      "THYROID_HYPO"  "THYROID_OTH"   "CANCER_LYMPH"  "CANCER_LEUK"
  #   "CANCER_METS" "OBESE"     "PERIVASC"    "CANCER_SOLID"  "CANCER_NSITU"  );

  VALANYPOA = c(
    'AIDS',
    'ALCOHOL',
    'AUTOIMMUNE',
    'LUNG_CHRONIC',
    'DEMENTIA',
    'DEPRESS',
    'DIAB_UNCX',
    'DIAB_CX',
    'DRUG_ABUSE',
    'HTN_UNCX',
    'HTN_CX',
    'THYROID_HYPO',
    'THYROID_OTH',
    'CANCER_LYMPH',
    'CANCER_LEUK',
    'CANCER_METS',
    'OBESE',
    'PERIVASC',
    'CANCER_SOLID',
    'CANCER_NSITU'
  )

  ###############################################################################################
  # The following block of SAS code is a copy of "CMR_Mapping_Program_v2022-1.sas" lines 158-171.
  ###############################################################################################
  # /****************************************************/
  #   /* If POA flags are available, create POA, exempt,  */
  #   /* and value arrays.                                */
  #   /****************************************************/
  #   %if &POA. = 1 %then %do;
  # ARRAY EXEMPTPOA (&NUMDX)  EXEMPTPOA1 - EXEMPTPOA&NUMDX;
  #
  # ARRAY DXPOA     (&NUMDX) $  &POAPREFIX.1 - &POAPREFIX.&NUMDX;
  #
  # ARRAY VALPOA    (19) $13 B1-B19
  # ("ANEMDEF"     "BLDLOSS"      "HF"         "COAG"       "LIVER_MLD"  "LIVER_SEV"
  #   "NEURO_MOVT"  "NEURO_SEIZ"   "NEURO_OTH"  "PARALYSIS"  "PSYCHOSES"  "PULMCIRC"   "RENLFL_MOD"
  #   "RENLFL_SEV"  "ULCER_PEPTIC" "WGHTLOSS"   "CBVD_POA"   "CBVD_SQLA"  "VALVE");
  # %end;


  # !R: These variables require POA status AND require "Y" or "W" POA (present)
  # !R: Note CBVD_POA requires POA status but requires "N" or "U" (not present)
  VALPOA = c(
    'ANEMDEF',
    'BLDLOSS',
    'HF',
    'COAG',
    'LIVER_MLD',
    'LIVER_SEV',
    'NEURO_MOVT',
    'NEURO_SEIZ',
    'NEURO_OTH',
    'PARALYSIS',
    'PSYCHOSES',
    'PULMCIRC',
    'RENLFL_MOD',
    'RENLFL_SEV',
    'ULCER_PEPTIC',
    'WGHTLOSS',
    'CBVD_POA',
    'CBVD_SQLA',
    'VALVE'
  )

  ###############################################################################################
  # The following block of SAS code is a copy of "CMR_Mapping_Program_v2022-1.sas" lines 173-198.
  ###############################################################################################
  #    /****************************************************/
  #    /* Initialize POA independent comorbidity flags to  */
  #    /* zero.                                            */
  #    /****************************************************/
  #    DO I = 1 TO 20;
  #       COMANYPOA(I) = 0;
  #    END;
  #
  #    /****************************************************/
  #    /* IF POA flags are available, initialize POA       */
  #    /* dependent comorbidiy flags to zero. If POA flags */
  #    /* are not available, these fields will be default  */
  #    /* to missing.                                      */
  #    /****************************************************/

  if (poa) {
    # %if &POA. = 1 %then %do;
    # DO I = 1 TO 19;
    # COMPOA(I) = 0;
    # END;
    # CMR_CBVD_NPOA   = 0;
    # CMR_CBVD        = 0;
    # EXEMPTPOA1      = 0;
    dt[, c('CMR_CBVD_NPOA', 'CMR_CBVD', 'EXEMPTPOA1') := 0] ###### "EXEMPTPOA" changed to "EXEMPTPOA1"
    #    %end;
  } else {
    #    %else %do;
    #    CMR_CBVD_NPOA   = .;
    #    CMR_CBVD        = .;
    dt[, c('CMR_CBVD_NPOA', 'CMR_CBVD') := NA]
    #    %end;
  }


  ###############################################################################################
  # The following block of SAS code is a copy of "CMR_Mapping_Program_v2022-1.sas" lines 200-226.
  ###############################################################################################
  # /****************************************************/
  # /* Examine each secondary diagnosis on a record and */
  # /* assign comorbidity flags.                        */
  # /* 1) Assign comorbidities which are neutral to POA */
  # /*    reporting.                                    */
  # /* 2) IF POA flags are available, assign            */
  # /*    comorbidities that require a diagnosis be     */
  # /*    present on admission and are not exempt from  */
  # /*    POA reporting.                                */
  # /* 3) IF POA flags are available, assign one        */
  # /*    comorbidity that requires that the diagnosis  */
  # /*    NOT be present admission.                     */
  # /****************************************************/
  #    DO I = 2 TO MIN(I10_NDX, &NUMDX);
  #       IF DX(I) NE " " THEN DO;
  #
  #          DXVALUE = PUT(DX(I),COMFMT.);


  #
  #          /****************************************************/
  #          /*   Assign Comorbidities that are neutral to POA   */
  #          /****************************************************/
  #          DO J = 1 TO 20;
  #             IF DXVALUE = VALANYPOA(J)  THEN COMANYPOA(J) = 1;
  #          END;

  dt[icd_seq==1, code := ''] # !R: Omit 1st diagnosis
  dxvalues = Elixhauser2022Formats$ElixhauserAHRQ2022Map$comfmt
  # !R: !VALPOA
  for (i in names(dxvalues)[!names(dxvalues) %in% VALPOA]) {
    dt[, paste0(i) := as.numeric(code %in% dxvalues[[i]])]
  }

  ###############################################################################################
  # The following set of logics are based on "CMR_Mapping_Program_v2022-1.sas" lines 221-232
  ###############################################################################################
  #          IF DXVALUE = "DRUG_ABUSEPSYCHOSES"  THEN DRUG_ABUSE= 1;
  dt[DRUG_ABUSEPSYCHOSES==1, CMR_DRUG_ABUSE := 1]
  #          IF DXVALUE = "CHFHTN_CX"            THEN HTN_CX    = 1;
  dt[CHFHTN_CX==1, CMR_HTN_CX := 1]
  #          IF DXVALUE = "HTN_CXRENLFL_SEV"     THEN HTN_CX    = 1;
  dt[HTN_CXRENLFL_SEV==1, CMR_HTN_CX := 1]
  #          IF DXVALUE = "CHFHTN_CXRENLFL_SEV"  THEN HTN_CX    = 1;
  dt[CHFHTN_CXRENLFL_SEV==1, CMR_HTN_CX := 1]
  #          IF DXVALUE = "ALCOHOLLIVER_MLD"     THEN ALCOHOL   = 1;
  dt[ALCOHOLLIVER_MLD==1, CMR_ALCOHOL := 1]
  #          IF DXVALUE = "VALVE_AUTOIMMUNE"     THEN CMR_AUTOIMMUNE= 1;
  dt[VALVE_AUTOIMMUNE==1, CMR_AUTOIMMUNE := 1]

  if (poa) {
    ###############################################################################################
    # The following set of logics are based on "CMR_Mapping_Program_v2022-1.sas" lines 234-247
    ###############################################################################################
    # %if &POA. = 1 %then %do;
    # /****************************************************/
    #   /* IF POA flags are available, assign comorbidities */
    #   /* requiring POA that are also not exempt from POA  */
    #   /* reporting.                                       */
    #   /****************************************************/
    #   EXEMPTPOA(I) = 0;
    #   IF (ICDVER = 39 AND PUT(DX(I),$poaxmpt_v39fmt.)='1') OR
    #   (ICDVER = 38 AND PUT(DX(I),$poaxmpt_v38fmt.)='1') OR
    #   (ICDVER = 37 AND PUT(DX(I),$poaxmpt_v37fmt.)='1') OR
    #   (ICDVER = 36 AND PUT(DX(I),$poaxmpt_v36fmt.)='1') OR
    #   (ICDVER = 35 AND PUT(DX(I),$poaxmpt_v35fmt.)='1') OR
    #   (ICDVER = 34 AND PUT(DX(I),$poaxmpt_v34fmt.)='1') OR
    #   (ICDVER = 33 AND PUT(DX(I),$poaxmpt_v33fmt.)='1') THEN EXEMPTPOA(I) = 1;

    # !R: if icd10cm_vers = NULL, formats extracted from year/quarter (see above)
    dt[ICDVER == 33,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v33fmt)]
    dt[ICDVER == 34,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v34fmt)]
    dt[ICDVER == 35,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v35fmt)]
    dt[ICDVER == 36,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v36fmt)]
    dt[ICDVER == 37,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v37fmt)]
    dt[ICDVER == 38,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v38fmt)]
    dt[ICDVER == 39,
       EXEMPTPOA := as.numeric(
         code %in%
           Elixhauser2022Formats$ElixhauserAHRQ2022Map$poaxmpt_v39fmt)]

    ###############################################################################################
    # The following set of logics are based on "CMR_Mapping_Program_v2022-1.sas" lines 249-267
    ###############################################################################################
    #          /**** Flag record if diagnosis is POA exempt or requires POA and POA ****/
    #          /**** indicates present on admission (Y or W) ****/
    #          IF (EXEMPTPOA(I) = 1)  or (EXEMPTPOA(I) = 0 AND DXPOA(I) IN ("Y","W")) THEN DO;
    #             DO K = 1 TO 19;
    #                IF DXVALUE = VALPOA(K)  THEN COMPOA(K) = 1;
    #             END;
    # !R: VALPOA w/conditions
    for (i in VALPOA) {
      dt[EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W')),
         paste0(i) := as.numeric(code %in% dxvalues[[i]])]
    }

    #             IF DXVALUE = "DRUG_ABUSEPSYCHOSES" THEN CMR_PSYCHOSES  = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         DRUG_ABUSEPSYCHOSES==1,
       CMR_PSYCHOSES := 1]

    #             IF DXVALUE = "HFHTN_CX"           THEN CMR_CHF        = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         HFHTN_CX==1,
       CMR_CHF := 1]

    #             IF DXVALUE = "HTN_CXRENLFL_SEV"    THEN CMR_RENLFL_SEV = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         HTN_CXRENLFL_SEV==1,
       CMR_RENLFL_SEV := 1]

    #             IF DXVALUE = "HFHTN_CXRENLFL_SEV" THEN DO;
    #                CMR_HF        = 1;
    #                CMR_RENLFL_SEV = 1;
    #             END;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         HFHTN_CXRENLFL_SEV==1,
       c('CMR_HF', 'CMR_RENLFL_SEV') := 1]

    #             IF DXVALUE = "CBVD_SQLAPARALYSIS"  THEN DO;
    #                CMR_PARALYSIS = 1;
    #                CMR_CBVD_SQLA = 1;
    #             END;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         CBVD_SQLAPARALYSIS==1,
       c('CMR_PARALYSIS', 'CMR_CBVD_SQLA') := 1]

    #             IF DXVALUE = "ALCOHOLLIVER_MLD"    THEN CMR_LIVER_MLD = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         ALCOHOLLIVER_MLD==1,
       CMR_LIVER_MLD := 1]
    #             IF DXVALUE = "VALVE_AUTOIMMUNE"    THEN CMR_VALVE     = 1;
    dt[(EXEMPTPOA==1 | (EXEMPTPOA==0 & poa_code %in% c('Y', 'W'))) &
         VALVE_AUTOIMMUNE==1,
       CMR_VALVE := 1]

    #          END;

    ###############################################################################################
    # The following set of logics are based on "CMR_Mapping_Program_v2022-1.sas" lines 270-278
    ###############################################################################################
    #          /****************************************************/
    #          /* IF POA flags are available, assign comorbidities */
    #          /* requiring that the diagnosis is not POA          */
    #          /****************************************************/
    #          IF (EXEMPTPOA(I) = 0 AND DXPOA(I) IN ("N","U")) THEN DO;
    #             IF DXVALUE = "CBVD_POA"  THEN CMR_CBVD_NPOA = 1;

    dt[EXEMPTPOA==0 & poa_code %in% c('N', 'U') &
         code %in% dxvalues$CBVD_POA,
       c('CMR_CBVD_NPOA') := 1]
  }
  #          END;
  #          %end;
  #       END;
  #    END;
  #

  #! R pivot_wider to get pre-exclusion assignments + IDs
  #! R make any NA -> 0
  for (i in names(dt)) {
    dt[is.na(get(i)), (i):=0]
  }

  to_pivot = c('id',
               Elixhauser2022Formats$ElixhauserAHRQ2022PreExclusion)
  # Remove columns in to_pivot that do not exist if poa=F
  to_pivot = to_pivot[to_pivot %in% colnames(dt)]
  dt = dt[, ..to_pivot]

  dt = dt[, lapply(.SD, sum), by=id,
          .SDcols = to_pivot[-1]]

  dt[, names(dt)[-1] := lapply(.SD, function(x) as.integer(x!=0)),
     .SDcols = names(dt)[-1]]


  ###############################################################################################
  # The following set of logics are based on "CMR_Mapping_Program_v2022-1.sas" lines 280-290
  ###############################################################################################
  #    /****************************************************/
  #    /* Implement exclusions for comorbidities that are  */
  #    /* neutral to POA.                                  */
  #    /****************************************************/
  #    IF CMR_DIAB_CX      = 1 then CMR_DIAB_UNCX   = 0;
  dt[CMR_DIAB_CX==1, CMR_DIAB_UNCX := 0]

  #    IF CMR_HTN_CX       = 1 then CMR_HTN_UNCX    = 0;
  dt[CMR_HTN_CX==1, CMR_HTN_UNCX := 0]

  #    IF CMR_CANCER_METS  = 1 THEN DO;
  #       CMR_CANCER_SOLID = 0;
  #       CMR_CANCER_NSITU = 0;
  dt[CMR_CANCER_METS==1, c('CMR_CANCER_SOLID', 'CMR_CANCER_NSITU') := 0]

  #    END;
  #    IF CMR_CANCER_SOLID = 1 then CMR_CANCER_NSITU = 0;
  dt[CMR_CANCER_SOLID==1, CMR_CANCER_NSITU := 0]
  #


  ###############################################################################################
  # The following set of logics are based on "CMR_Mapping_Program_v2022-1.sas" lines 292-299
  ###############################################################################################
  if (poa) {
    #    /****************************************************/
    #    /* IF POA flags are available, implement exclusions */
    #    /* for comorbidities requiring POA.                 */
    #    /****************************************************/
    #    %if &POA. = 1 %then %do;
    #    IF CMR_LIVER_SEV    = 1 THEN CMR_LIVER_MLD   = 0;
    dt[CMR_LIVER_SEV==1, CMR_LIVER_MLD := 0]

    #    IF CMR_RENLFL_SEV   = 1 THEN CMR_RENLFL_MOD  = 0;
    dt[CMR_RENLFL_SEV==1, CMR_RENLFL_MOD := 0]

    #    IF (CMR_CBVD_POA=1) OR (CMR_CBVD_POA=0 AND CMR_CBVD_NPOA=0 AND CMR_CBVD_SQLA=1) THEN CMR_CBVD = 1;
    dt[(CMR_CBVD_POA==1) | (CMR_CBVD_POA==0 & CMR_CBVD_NPOA==0 & CMR_CBVD_SQLA==1),
       CMR_CBVD := 1]
  }
  #    %end;
  #
  # !R: Remainder of SAS code not relevant

  # !R: Get final comorbidities
  keep_vars = c('id',
                Elixhauser2022Formats$ElixhauserAHRQ2022Abbr)
  # Drop vars that don't exist if poa=T
  keep_vars = keep_vars[keep_vars %in% colnames(dt)]
  dt = dt[, ..keep_vars]

  # Compute total score
  dt[, score := rowSums(.SD),
     .SDcols = keep_vars[-1]]

  # Rename id back to user-specified
  data.table::setnames(dt, new_col_names, names(new_col_names),
                       skip_absent = T)

  # Return as data.frame
  as.data.frame(dt)
}




