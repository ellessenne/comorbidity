  # /*******************************************/
  # /* Initialize Hypertension, CHF, and Renal */
  # /* Comorbidity flags to 1 using the detail */
  # /* hypertension flags.                     */
  # /*******************************************/
  # IF HTNPREG_  THEN HTNCX = 1;
x$HTNCX[x$HTNPREG==1] = 1

  # IF HTNWOCHF_ THEN HTNCX = 1;
x$HTNCX[x$HTNWOCHF==1] = 1

  # IF HTNWCHF_  THEN DO;
  #   HTNCX    = 1;
  #   CHF      = 1;
x[x$HTNWCHF==1, c('HTNCX', 'CHF')] = 1
  # END;

  # IF HRENWORF_ THEN HTNCX = 1;
x$HTNCX[x$HRENWORF==1] = 1

  # IF HRENWRF_  THEN DO;
  #   HTNCX    = 1;
  #   RENLFAIL = 1;
x[x$HRENWRF==1, c('HTNCX', 'RENLFAIL')] = 1
  # END;

  # IF HHRWOHRF_ THEN HTNCX = 1;
x$HTNCX[x$HHRWOHRF==1] = 1

  # IF HHRWCHF_  THEN DO;
  # HTNCX    = 1;
  # CHF      = 1;
  # END;
x[x$HHRWCHF==1, c('HTNCX', 'CHF')] = 1

  # IF HHRWRF_   THEN DO;
  # HTNCX    = 1;
  # RENLFAIL = 1;
  # END;
x[x$HHRWRF==1, c('HTNCX', 'RENLFAIL')] = 1

  # IF HHRWHRF_  THEN DO;
  # HTNCX    = 1;
  # CHF      = 1;
  # RENLFAIL = 1;
  # END;
x[x$HHRWHRF==1, c('HTNCX', 'CHF', 'RENLFAIL')] = 1

  # IF OHTNPREG_ THEN HTNCX = 1;
x$HTNCX[x$OHTNPREG==1] = 1

  # 
  # 
  #   /*********************************************************/
  #   /* Set up code to only count the more severe comorbidity */
  #   /*********************************************************/ 
  #   IF HTNCX = 1 THEN HTN = 0 ;
x$HTN[x$HTNCX==1] = 0

  #   IF METS = 1 THEN TUMOR = 0 ;
x$TUMOR[x$METS==1] = 0

  #   IF DMCX = 1 THEN DM = 0 ;
x$DM[x$DMCX==1] = 0

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

###!!!compute_ahrq (to be renamed and implemented elsewhere)
###!!! huh = list of drg_flags by id
x[names(lofmsdrg)] = NA
for (i in names(drg_flags)) {
  x[i, drg_flags[[i]]] = 1
}

  #     
  #     
  #       /************************************************************/
  #       /* Redefining comorbidities by eliminating the DRG directly */
  #       /* related to comorbidity, thus limiting the screens to     */
  #       /* principal diagnoses not directly related to comorbidity  */
  #       /* in question                                              */
  #       /************************************************************/  
  #       IF CHF   	AND CARDFLG  				THEN CHF 		= 0;
x$CHF[x$CHF==1 & x$CARDDRG==1] = 0

  #       IF VALVE 	AND CARDFLG   				THEN VALVE 		= 0;
x$VALVE[x$VALVE==1 & x$CARDDRG==1] = 0

  #       IF PULMCIRC  AND (CARDFLG OR PULMFLG ) 	THEN PULMCIRC 	= 0;
x$PULMCIRC[x$PULMCIRC==1 & (x$CARDDRG==1 | x$PULMDRG==1)] = 0

  #       IF PERIVASC  AND PERIFLG 				THEN PERIVASC 	= 0;
x$PERIVASC[x$PERIVASC==1 & x$PERIDRG==1] = 0

  #       IF HTN 		AND HTNFLG 					THEN HTN 		= 0;
x$HTN[x$HTN==1 & x$HTNDRG==1] = 0

  #       
  #         /**********************************************************/
  #         /* Apply DRG Exclusions to Hypertension Complicated, Con- */
  #         /* gestive Heart Failure, and Renal Failure comorbidities */
  #         /* using the detailed hypertension flags created above.   */
  #         /**********************************************************/
  #         IF HTNCX     AND HTNCXFLG THEN HTNCX = 0  ;
x$HTNCX[x$HTNCX==1 & x$HTNCXDRG==1] = 0

  #         IF HTNPREG_  AND HTNCXFLG THEN HTNCX = 0;
x$HTNCX[x$HTNPREG==1 & x$HTNCXDRG==1] = 0

  #         IF HTNWOCHF_ AND (HTNCXFLG OR CARDFLG) THEN HTNCX = 0;
x$HTNCX[x$HTNWOCHF==1 & (x$HTNCXDRG==1 | x$CARDDRG==1)] = 0

  #         IF HTNWCHF_  THEN DO;
  #           IF HTNCXFLG THEN HTNCX  = 0;
x$HTNCX[x$HTNWCHF==1 & x$HTNCXDRG==1] = 0

  #           IF CARDFLG THEN DO;
  #             HTNCX = 0;
x$HTNCX[x$HTNWCHF==1 & x$CARDDRG==1] = 0
  #             CHF   = 0;
x$CHF[x$HTNWCHF==1 & x$CARDDRG==1] = 0

  #           END;
  #         END;

  #         IF HRENWORF_ AND (HTNCXFLG OR RENALFLG) THEN HTNCX = 0;
x$HTNCX[x$HRENWORF==1 & (x$HTNCXDRG==1 | x$RENALDRG==1)] = 0

  #         IF HRENWRF_  THEN DO;
  #           IF HTNCXFLG THEN HTNCX = 0;
x$HTNCX[x$HRENWRF==1 & x$HTNCXDRG==1] = 0

  #           IF RENALFLG THEN DO;
  #             HTNCX    = 0;
  #             RENLFAIL = 0;
x[x$HRENWRF==1 & x$RENALDRG==1, c('HTNCX', 'RENLFAIL')] = 0

  #           END;
  #         END;

  #         IF HHRWOHRF_ AND (HTNCXFLG OR CARDFLG OR RENALFLG) THEN HTNCX = 0;
x$HTNCX[x$HRENWORF==1 & (x$HTNCXDRG==1 | x$CARDDRG==1 | x$RENALDRG==1)] = 0

  #         IF HHRWCHF_ THEN DO;
  #           IF HTNCXFLG THEN HTNCX = 0;
x$HTNCX[x$HHRWCHF==1 & x$HTNCXDRG==1] = 0

  #             IF CARDFLG THEN DO;
  #               HTNCX = 0;
  #               CHF   = 0;
x[x$HHRWCHF==1 & x$CARDDRG==1, c('HTNCX', 'CHF')] = 0

  #             END;
  #         IF RENALFLG THEN HTNCX = 0;
x$HTNCX[x$HHRWCHF==1 & x$RENALDRG==1] = 0

  #         END;


  #         IF HHRWRF_ THEN DO;
  #           IF HTNCXFLG OR CARDFLG THEN HTNCX = 0;
x$HTNCX[x$HHRWRF==1 & (x$HTNCXDRG==1 | x$CARDDRG==1)] = 0

  #           IF RENALFLG THEN DO;
  #             HTNCX    = 0;
  #             RENLFAIL = 0;
x[x$HHRWRF==1 & x$RENALDRG==1, c('HTNCX', 'RENLFAIL')] = 0

  #           END;
  #         END;

  #         IF HHRWHRF_ THEN DO;
  #           IF HTNCXFLG THEN HTNCX = 0;
x$HTNCX[x$HHRWHRF==1 & x$HTNCXDRG==1] = 0

  #           IF CARDFLG THEN DO;
  #             HTNCX = 0;
  #             CHF   = 0;
x[x$HHRWHRF==1 & x$CARDDRG==1, c('HTNCX', 'CHF')] = 0

  #           END;
  #           IF RENALFLG THEN DO;
  #           HTNCX    = 0;
  #           RENLFAIL = 0;
x[x$HHRWHRF==1 & x$RENALFLG==1, c('HTNCX', 'RENLFAIL')] = 0

  #           END;
  #         END;
  #         IF OHTNPREG_ AND (HTNCXFLG OR CARDFLG OR RENALFLG) THEN HTNCX = 0;
x$HTNCX[x$OHTNPREG==1 & (x$HTNCXDRG==1 | x$CARDDRG==1 | x$RENALDRG==1)] = 0

  #         
  #         IF NEURO AND NERVFLG THEN NEURO = 0;
x$NEURO[x$NEURO==1 & x$NERVDRG==1] = 0

  #         IF CHRNLUNG AND PULMFLG THEN CHRNLUNG = 0;
x$CHRNLUNG[x$CHRNLUNG==1 & x$PULMDRG==1] = 0

  #         IF DM AND DIABFLG THEN DM = 0;
x$DM[x$DM==1 & x$DIABDRG==1] = 0

  #         IF DMCX AND DIABFLG THEN DMCX = 0 ;
x$DMCX[x$DMCX==1 & x$DIABDRG==1] = 0

  #         IF HYPOTHY AND HYPOFLG THEN HYPOTHY = 0;
x$HYPOTHY[x$HYPOTHY==1 & x$HYPODRG==1] = 0

  #         IF RENLFAIL AND RENFFLG THEN   RENLFAIL = 0;
x$RENLFAIL[x$RENLFAIL==1 & x$RENFDRG==1] = 0

  #         IF LIVER AND LIVERFLG THEN LIVER = 0;
x$LIVER[x$LIVER==1 & x$LIVERDRG==1] = 0

  #         IF ULCER AND ULCEFLG THEN  ULCER = 0;
x$ULCER[x$ULCER==1 & x$ULCEDRG==1] = 0

  #         IF AIDS AND HIVFLG THEN AIDS = 0;
x$AIDS[x$AIDS==1 & x$HIVDRG==1] = 0

  #         IF LYMPH AND LEUKFLG THEN LYMPH = 0;
x$LYMPH[x$LYMPH==1 & x$LEUKDRG==1] = 0

  #         IF METS AND CANCFLG THEN METS = 0;
x$METS[x$METS==1 & x$CANCDRG==1] = 0

  #         IF TUMOR AND CANCFLG THEN TUMOR = 0;
x$TUMOR[x$TUMOR==1 & x$CANCDRG==1] = 0

  #         IF ARTH AND ARTHFLG THEN ARTH = 0;
x$ARTH[x$ARTH==1 & x$ARTHDRG==1] = 0

  #         IF COAG AND COAGFLG THEN COAG = 0;
x$COAG[x$COAG==1 & x$COAGFLG==1] = 0

  #         IF OBESE AND (NUTRFLG OR OBESEFLG) THEN  OBESE = 0;
x$OBESE[x$OBESE==1 & (x$NUTRFLG==1 | x$OBESEDRG==1)] = 0

  #         IF WGHTLOSS AND NUTRFLG THEN WGHTLOSS = 0;
x$WGHTLOSS[x$WGHTLOSS==1 & x$NUTRDRG==1] = 0

  #         IF LYTES AND NUTRFLG THEN LYTES = 0;
x$LYTES[x$LYTES==1 & x$NUTRDRG==1] = 0

  #         IF BLDLOSS AND ANEMFLG THEN BLDLOSS = 0;
x$BLDLOSS[x$BLDLOSS==1 & x$ANEMDRG==1] = 0

  #         IF ANEMDEF AND ANEMFLG THEN ANEMDEF = 0;
x$ANEMDEF[x$ANEMDEF==1 & x$ANEMDRG==1] = 0

  #         IF ALCOHOL AND ALCFLG THEN ALCOHOL = 0;
x$ALCOHOL[x$ALCOHOL==1 & x$ALCFLG==1] = 0

  #         IF DRUG AND ALCFLG THEN DRUG = 0;
x$DRUG[x$DRUG==1 & x$ALCDRG==1] = 0

  #         IF PSYCH AND PSYFLG THEN PSYCH = 0;
x$PSYCH[x$PSYCH==1 & x$PSYDRG==1] = 0

  #         IF DEPRESS AND DEPRSFLG THEN DEPRESS = 0;
x$DEPRESS[x$DEPRESS==1 & x$DEPRSDRG==1] = 0

  #         IF PARA AND CEREFLG THEN PARA = 0;
x$PARA[x$PARA==1 & x$CEREDRG==1] = 0

  #         
  #         /*************************************/
  #           /*  Combine HTN and HTNCX into HTN_C */
  #           /*************************************/
  #           ATTRIB HTN_C LENGTH=3 LABEL='Hypertension';
  #           
  #           IF HTN=1 OR HTNCX=1 THEN HTN_C=1;
  #           ELSE HTN_C=0;
x$HTN_C = ifelse(x$HTN==1 | x$HTNCX==1, 1, 0)
