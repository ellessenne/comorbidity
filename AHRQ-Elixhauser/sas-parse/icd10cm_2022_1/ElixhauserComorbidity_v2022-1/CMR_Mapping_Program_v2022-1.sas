/******************************************************************/
/* Title:       ELIXHAUSER COMORBIDITY SOFTWARE REFINED           */
/*              FOR ICD-10-CM MAPPING PROGRAM                     */
/*                                                                */
/* Program:     CMR_Mapping_Program_v2022-1.SAS                   */
/*                                                                */
/* Diagnoses:   v2022-1 is compatible with ICD-10-CM diagnosis    */
/*              codes from October 2015 through September 2022.   */
/*              ICD-10-CM codes should not include embedded       */
/*              decimals (example: S0100XA, not S01.00XA).        */
/*                                                                */
/* Description: This SAS mapping program assigns the Elixhauser   */
/*              comorbidity measures from ICD-10-CM secondary     */
/*              diagnoses. Some comorbidities require additional  */
/*              information on whether the diagnosis was present  */
/*              on admission (POA). Please specify below if POA   */
/*              indicators are available in your data. If POA     */
/*              information is not available, comorbidities that  */
/*              require POA will be set to missing.               */
/*                                                                */
/* Note:	    The SAS program CMR_Format_Program_v2022-1 must   */
/*	            be run prior to running this mapping program.     */
/*                                                                */
/* Output:	    This program appends the comorbidity measures     */
/*	            to the input SAS file.  The data elements start   */
/*              with the 4-character prefix CMR_                  */
/*                                                                */
/******************************************************************/

/*******************************************************************/
/*      THE SAS MACRO FLAGS BELOW MUST BE UPDATED BY THE USER      */ 
/*  These macro variables must be set to define the locations,     */
/*  names, and characteristics of your input and output SAS        */
/*  formatted data.                                                */
/*******************************************************************/

/**********************************************/
/*          SPECIFY FILE LOCATIONS            */
/**********************************************/
LIBNAME LIBRARY 'C:\COMORB\FMTLIB\';                  * Location of format library.       <===USER MUST MODIFY;	   
LIBNAME  IN1    'c:\sasdata\';                        * Location of input discharge data. <===USER MUST MODIFY;
LIBNAME  OUT1   'c:\sasdata\';                        * Location of output data.          <===USER MUST MODIFY;


/*********************************************/
/*   SPECIFY INPUT FILE CHARACTERISTICS      */
/*********************************************/ 
* Specify the prefix used to name the ICD-10-CM
  diagnosis data element array in the input dataset.
  In this example the diagnosis data elements would be 
  named I10_DX1, I10_DX2, etc., similar to the naming 
  of ICD-10-CM data elements in HCUP databases;            %LET DXPREFIX=I10_DX;  *<===USER MUST MODIFY;
  
* Specify the maximum number of diagnosis codes
  on any record in the input file. ;                       %LET NUMDX = 15;       *<===USER MUST MODIFY;

* Specify the name of the variable that contains a 
  count of the ICD-10-CM codes coded on a record. if  
  no such variable exists, leave macro blank;              %LET NDXVAR=I10_NDX;   *<=== USER MUST MODIFY;

* Specify if indicators that diagnosis is present
  On admission are available (1=yes, 0=no);                %LET POA   = 1;        *<===USER MUST MODIFY;

* Specify the prefix used to name the diagnosis present
  on admission (POA) data element array in the input dataset.
  In this example the POA data elements would be 
  named DXPOA1, DXPOA2, etc., similar to the naming 
  of POA data elements in HCUP databases;                  %LET POAPREFIX=DXPOA;  *<===USER MUST MODIFY;

* Set the number of observations to use from 
  your dataset (use MAX for all observations,
  other values for testing);                               %LET OBS    = MAX;     *<===USER MAY MODIFY; 

/**********************************************/
/*          SPECIFY FILE NAMES                */
/**********************************************/
* Input SAS file member name;                              %Let CORE = YOUR_SAS_INPUT_FILE_HERE;     *<===USER MUST MODIFY;            
* Output SAS file member name;                             %Let OUT  = YOUR_SAS_OUTPUT_FILE_HERE;    *<===USER MUST MODIFY;


/*********************************************/
/*   SET CMR VERSION                         */
/*********************************************/ 
%LET CMR_VERSION = "2022.1" ;               *<=== DO NOT MODIFY;


TITLE1 'Elixhauser Comorbidity Software Refined for ICD-10-CM Diagnoses';
TITLE2 'Comorbidity Mapping Program';


%macro comorbidity;
DATA OUT1.&OUT.;
   LABEL  CMR_VERSION = "Version of Elixhauser Comorbidity Software Refined";
   RETAIN CMR_VERSION &CMR_VERSION;
   
   SET IN1.&CORE ;
   
   DROP I J  DXVALUE A1-A20 %if &POA.=1 %then %do;B1-B19 K %end;  CMR_CBVD_SQLA CMR_CBVD_POA CMR_CBVD_NPOA ;

   /*****************************************/
   /*    Establish the ICD-10-CM Version    */
   /* This will default to the last version */
   /* for discharges outside of coding      */
   /* updates.                              */
   /*****************************************/ 
   ATTRIB ICDVER LENGTH=3 LABEL='ICD-10-CM VERSION';

   ICDVER = 0;

   IF      (YEAR IN (2015) AND DQTR IN (4))     THEN ICDVER = 33;
   ELSE IF (YEAR IN (2016) AND DQTR IN (1,2,3)) THEN ICDVER = 33;
   ELSE IF (YEAR IN (2016) AND DQTR IN (4))     THEN ICDVER = 34;
   ELSE IF (YEAR IN (2017) AND DQTR IN (1,2,3)) THEN ICDVER = 34;
   ELSE IF (YEAR IN (2017) AND DQTR IN (4))     THEN ICDVER = 35;
   ELSE IF (YEAR IN (2018) AND DQTR IN (1,2,3)) THEN ICDVER = 35;
   ELSE IF (YEAR IN (2018) AND DQTR IN (4))     THEN ICDVER = 36;
   ELSE IF (YEAR IN (2019) AND DQTR IN (1,2,3)) THEN ICDVER = 36;
   ELSE IF (YEAR IN (2019) AND DQTR IN (4))     THEN ICDVER = 37;
   ELSE IF (YEAR IN (2020) AND DQTR IN (1,2,3)) THEN ICDVER = 37;
   ELSE IF (YEAR IN (2020) AND DQTR IN (4))     THEN ICDVER = 38;
   ELSE IF (YEAR IN (2021) AND DQTR IN (1,2,3)) THEN ICDVER = 38;
   ELSE IF (YEAR IN (2021) AND DQTR IN (4))     THEN ICDVER = 39;
   ELSE IF (YEAR IN (2022) AND DQTR IN (1,2,3)) THEN ICDVER = 39;
   ELSE                                              ICDVER = 39; 

   /********************************************/
   /* Establish lengths for all comorbidity    */
   /* flags.                                   */
   /********************************************/ 
   LENGTH   DXVALUE $20
   
            CMR_AIDS         CMR_ALCOHOL     CMR_ANEMDEF      CMR_AUTOIMMUNE CMR_BLDLOSS   CMR_CANCER_LYMPH CMR_CANCER_LEUK  CMR_CANCER_METS CMR_CANCER_NSITU 
            CMR_CANCER_SOLID CMR_CBVD_SQLA   CMR_CBVD_POA     CMR_CBVD_NPOA  CMR_CBVD      CMR_HF CMR_COAG  CMR_DEMENTIA     CMR_DEPRESS     CMR_DIAB_UNCX 
            CMR_DIAB_CX      CMR_DRUG_ABUSE  CMR_HTN_CX       CMR_HTN_UNCX   CMR_LIVER_MLD CMR_LIVER_SEV    CMR_LUNG_CHRONIC CMR_NEURO_MOVT 
            CMR_NEURO_OTH    CMR_NEURO_SEIZ  CMR_OBESE        CMR_PARALYSIS  CMR_PERIVASC  CMR_PSYCHOSES    CMR_PULMCIRC     CMR_RENLFL_MOD  CMR_RENLFL_SEV
            CMR_THYROID_HYPO CMR_THYROID_OTH CMR_ULCER_PEPTIC CMR_VALVE      CMR_WGHTLOSS  3.
            ;            

   /********************************************/
   /* Create diagnosis and comorbidity arrays  */
   /* for all comorbidity flags.               */
   /********************************************/ 
   ARRAY DX        (&NUMDX) $  &DXPREFIX.1 - &DXPREFIX.&NUMDX;
   
   ARRAY COMANYPOA  (20) CMR_AIDS       CMR_ALCOHOL    CMR_AUTOIMMUNE   CMR_LUNG_CHRONIC CMR_DEMENTIA    CMR_DEPRESS      CMR_DIAB_UNCX   CMR_DIAB_CX 
                         CMR_DRUG_ABUSE CMR_HTN_UNCX   CMR_HTN_CX       CMR_THYROID_HYPO CMR_THYROID_OTH CMR_CANCER_LYMPH CMR_CANCER_LEUK CMR_CANCER_METS 
                         CMR_OBESE      CMR_PERIVASC   CMR_CANCER_SOLID CMR_CANCER_NSITU ;
  
   ARRAY COMPOA     (19) CMR_ANEMDEF      CMR_BLDLOSS   CMR_HF        CMR_COAG      CMR_LIVER_MLD CMR_LIVER_SEV  CMR_NEURO_MOVT   
                         CMR_NEURO_SEIZ   CMR_NEURO_OTH CMR_PARALYSIS CMR_PSYCHOSES CMR_PULMCIRC  CMR_RENLFL_MOD CMR_RENLFL_SEV 
                         CMR_ULCER_PEPTIC CMR_WGHTLOSS  CMR_CBVD_POA  CMR_CBVD_SQLA CMR_VALVE ;
                         
   ARRAY VALANYPOA  (20) $13 A1-A20 
                       ("AIDS"        "ALCOHOL"   "AUTOIMMUNE"  "LUNG_CHRONIC"  "DEMENTIA"      "DEPRESS"       "DIAB_UNCX"     "DIAB_CX" 
                        "DRUG_ABUSE"  "HTN_UNCX"  "HTN_CX"      "THYROID_HYPO"  "THYROID_OTH"   "CANCER_LYMPH"  "CANCER_LEUK"  
                        "CANCER_METS" "OBESE"     "PERIVASC"    "CANCER_SOLID"  "CANCER_NSITU"  );           
                    
   /****************************************************/
   /* If POA flags are available, create POA, exempt,  */
   /* and value arrays.                                */               
   /****************************************************/                 
   %if &POA. = 1 %then %do;
   ARRAY EXEMPTPOA (&NUMDX)  EXEMPTPOA1 - EXEMPTPOA&NUMDX;
   
   ARRAY DXPOA     (&NUMDX) $  &POAPREFIX.1 - &POAPREFIX.&NUMDX;
                            
   ARRAY VALPOA    (19) $13 B1-B19
                       ("ANEMDEF"     "BLDLOSS"      "HF"         "COAG"       "LIVER_MLD"  "LIVER_SEV"  
                        "NEURO_MOVT"  "NEURO_SEIZ"   "NEURO_OTH"  "PARALYSIS"  "PSYCHOSES"  "PULMCIRC"   "RENLFL_MOD" 
                        "RENLFL_SEV"  "ULCER_PEPTIC" "WGHTLOSS"   "CBVD_POA"   "CBVD_SQLA"  "VALVE");
   %end;            

   /****************************************************/
   /* Initialize POA independent comorbidity flags to  */
   /* zero.                                            */
   /****************************************************/
   DO I = 1 TO 20;
      COMANYPOA(I) = 0;
   END;
   
   /****************************************************/
   /* IF POA flags are available, initialize POA       */
   /* dependent comorbidiy flags to zero. If POA flags */
   /* are not available, these fields will be default  */
   /* to missing.                                      */
   /****************************************************/
   %if &POA. = 1 %then %do;
   DO I = 1 TO 19;
      COMPOA(I) = 0;
   END;
   CMR_CBVD_NPOA   = 0;
   CMR_CBVD        = 0; 
   EXEMPTPOA1      = 0;  
   %end;
   %else %do;
   CMR_CBVD_NPOA   = .;
   CMR_CBVD        = .;
   %end;
   
   /****************************************************/
   /* Examine each secondary diagnosis on a record and */
   /* assign comorbidity flags.                        */
   /* 1) Assign comorbidities which are neutral to POA */
   /*    reporting.                                    */
   /* 2) IF POA flags are available, assign            */
   /*    comorbidities that require a diagnosis be     */
   /*    present on admission and are not exempt from  */
   /*    POA reporting.                                */
   /* 3) IF POA flags are available, assign one        */
   /*    comorbidity that requires that the diagnosis  */
   /*    NOT be present admission.                     */
   /****************************************************/
   %if &NDXVAR ne %then %let MAXNDX = &NDXVAR;
   %else                %let MAXNDX = &NUMDX;
   
   DO I = 2 TO MIN(&MAXNDX,&NUMDX); 
      IF DX(I) NE " " THEN DO;
                  
         DXVALUE = PUT(DX(I),COMFMT.);

         /****************************************************/
         /*   Assign Comorbidities that are neutral to POA   */
         /****************************************************/
         DO J = 1 TO 20;
            IF DXVALUE = VALANYPOA(J)  THEN COMANYPOA(J) = 1;  
         END;         
         IF DXVALUE = "DRUG_ABUSEPSYCHOSES"  THEN CMR_DRUG_ABUSE= 1;
         IF DXVALUE = "HFHTN_CX"             THEN CMR_HTN_CX    = 1;
         IF DXVALUE = "HTN_CXRENLFL_SEV"     THEN CMR_HTN_CX    = 1;
         IF DXVALUE = "HFHTN_CXRENLFL_SEV"   THEN CMR_HTN_CX    = 1;
         IF DXVALUE = "ALCOHOLLIVER_MLD"     THEN CMR_ALCOHOL   = 1;
         IF DXVALUE = "VALVE_AUTOIMMUNE"     THEN CMR_AUTOIMMUNE= 1;         
                                 
         %if &POA. = 1 %then %do;
         /****************************************************/
         /* IF POA flags are available, assign comorbidities */
         /* requiring POA that are also not exempt from POA  */
         /* reporting.                                       */
         /****************************************************/
         EXEMPTPOA(I) = 0;
         IF (ICDVER = 39 AND PUT(DX(I),$poaxmpt_v39fmt.)='1') OR
            (ICDVER = 38 AND PUT(DX(I),$poaxmpt_v38fmt.)='1') OR
            (ICDVER = 37 AND PUT(DX(I),$poaxmpt_v37fmt.)='1') OR
            (ICDVER = 36 AND PUT(DX(I),$poaxmpt_v36fmt.)='1') OR
            (ICDVER = 35 AND PUT(DX(I),$poaxmpt_v35fmt.)='1') OR
            (ICDVER = 34 AND PUT(DX(I),$poaxmpt_v34fmt.)='1') OR
            (ICDVER = 33 AND PUT(DX(I),$poaxmpt_v33fmt.)='1') THEN EXEMPTPOA(I) = 1;          
            
         /**** Flag record if diagnosis is POA exempt or requires POA and POA indicates present on admission (Y or W) ****/
         IF (EXEMPTPOA(I) = 1)  or (EXEMPTPOA(I) = 0 AND DXPOA(I) IN ("Y","W")) THEN DO;
            DO K = 1 TO 19;
               IF DXVALUE = VALPOA(K)  THEN COMPOA(K) = 1;  
            END;
            IF DXVALUE = "DRUG_ABUSEPSYCHOSES" THEN CMR_PSYCHOSES  = 1;
            IF DXVALUE = "HFHTN_CX"            THEN CMR_HF         = 1;
            IF DXVALUE = "HTN_CXRENLFL_SEV"    THEN CMR_RENLFL_SEV = 1;
            IF DXVALUE = "HFHTN_CXRENLFL_SEV"  THEN DO;
               CMR_HF         = 1;
               CMR_RENLFL_SEV = 1;
            END;                          
            IF DXVALUE = "CBVD_SQLAPARALYSIS"  THEN DO;
               CMR_PARALYSIS = 1;
               CMR_CBVD_SQLA = 1;
            END;
            IF DXVALUE = "ALCOHOLLIVER_MLD"    THEN CMR_LIVER_MLD = 1; 
            IF DXVALUE = "VALVE_AUTOIMMUNE"    THEN CMR_VALVE     = 1;  
         END;
         
         /****************************************************/
         /* IF POA flags are available, assign comorbidities */
         /* requiring that the diagnosis is not POA          */
         /****************************************************/
         IF (EXEMPTPOA(I) = 0 AND DXPOA(I) IN ("N","U")) THEN DO;
            IF DXVALUE = "CBVD_POA"  THEN CMR_CBVD_NPOA = 1;  
         END;
         %end;
      END;        
   END;   
   
   /****************************************************/
   /* Implement exclusions for comorbidities that are  */
   /* neutral to POA.                                  */
   /****************************************************/
   IF CMR_DIAB_CX      = 1 THEN CMR_DIAB_UNCX   = 0;
   IF CMR_HTN_CX       = 1 THEN CMR_HTN_UNCX    = 0;
   IF CMR_CANCER_METS  = 1 THEN DO; 
      CMR_CANCER_SOLID = 0; 
      CMR_CANCER_NSITU = 0; 
   END;
   IF CMR_CANCER_SOLID = 1 THEN CMR_CANCER_NSITU = 0;   
   
   /****************************************************/
   /* IF POA flags are available, implement exclusions */
   /* for comorbidities requiring POA.                 */
   /****************************************************/
   %if &POA. = 1 %then %do;
   IF CMR_LIVER_SEV    = 1 THEN CMR_LIVER_MLD   = 0;
   IF CMR_RENLFL_SEV   = 1 THEN CMR_RENLFL_MOD  = 0;
   IF (CMR_CBVD_POA=1) OR (CMR_CBVD_POA=0 AND CMR_CBVD_NPOA=0 AND CMR_CBVD_SQLA=1) THEN CMR_CBVD = 1; 
   %end;    

   LABEL
        CMR_AIDS         = 'Acquired immune deficiency syndrome' 
        CMR_ALCOHOL      = 'Alcohol abuse'    
        CMR_ANEMDEF      = 'Deficiency anemias'      
        CMR_AUTOIMMUNE   = 'Autoimmune conditions'
        CMR_BLDLOSS      = 'Chronic blood loss anemia'   
        CMR_CANCER_LEUK  = 'Leukemia'
        CMR_CANCER_LYMPH = 'Lymphoma'
        CMR_CANCER_METS  = 'Metastatic cancer'
        CMR_CANCER_NSITU = 'Solid tumor without metastasis, in situ'
        CMR_CANCER_SOLID = 'Solid tumor without metastasis, malignant' 
        CMR_CBVD         = 'Cerebrovascular disease'
        CMR_CBVD_NPOA    = 'Cerebrovascular disease, not on admission'
        CMR_CBVD_POA     = 'Cerebrovascular disease, on admission'
        CMR_CBVD_SQLA    = 'Cerebrovascular disease, sequela'
        CMR_HF           = 'Heart failure'
        CMR_COAG         = 'Coagulopathy' 
        CMR_DEMENTIA     = 'Dementia'
        CMR_DEPRESS      = 'Depression'
        CMR_DIAB_CX      = 'Diabetes with chronic complications'
        CMR_DIAB_UNCX    = 'Diabetes without chronic complications'
        CMR_DRUG_ABUSE   = 'Drug abuse'
        CMR_HTN_CX       = 'Hypertension, complicated' 
        CMR_HTN_UNCX     = 'Hypertension, uncomplicated'
        CMR_LIVER_MLD    = 'Liver disease, mild'
        CMR_LIVER_SEV    = 'Liver disease, moderate to severe'
        CMR_LUNG_CHRONIC = 'Chronic pulmonary disease'
        CMR_NEURO_MOVT   = 'Neurological disorders affecting movement'
        CMR_NEURO_OTH    = 'Other neurological disorders' 
        CMR_NEURO_SEIZ   = 'Seizures and epilepsy'            
        CMR_OBESE        = 'Obesity'    
        CMR_PARALYSIS    = 'Paralysis'
        CMR_PERIVASC     = 'Peripheral vascular disease'
        CMR_PSYCHOSES    = 'Psychoses'
        CMR_PULMCIRC     = 'Pulmonary circulation disease'    
        CMR_RENLFL_MOD   = 'Renal failure, moderate'
        CMR_RENLFL_SEV   = 'Renal failure, severe' 
        CMR_THYROID_HYPO = 'Hypothyroidism'
        CMR_THYROID_OTH  = 'Other thyroid disorders'
        CMR_ULCER_PEPTIC = 'Peptic ulcer disease x bleeding'     
        CMR_VALVE        = 'Valvular disease'
        CMR_WGHTLOSS     = 'Weight loss'         
        ;
RUN;
%mend comorbidity;
%comorbidity;



/***********************************/
/*  Means on comorbidity variables */
/***********************************/
PROC MEANS DATA=OUT1.&OUT.  N NMISS MEAN STD MIN MAX;
   VAR    
      CMR_AIDS         CMR_ALCOHOL      CMR_ANEMDEF      CMR_AUTOIMMUNE  CMR_BLDLOSS      CMR_CANCER_LYMPH CMR_CANCER_LEUK  
      CMR_CANCER_METS  CMR_CANCER_NSITU CMR_CANCER_SOLID CMR_CBVD        CMR_HF           CMR_COAG         CMR_DEMENTIA     CMR_DEPRESS
      CMR_DIAB_UNCX    CMR_DIAB_CX      CMR_DRUG_ABUSE   CMR_HTN_CX      CMR_HTN_UNCX     CMR_LIVER_MLD    CMR_LIVER_SEV    CMR_LUNG_CHRONIC 
      CMR_NEURO_MOVT   CMR_NEURO_OTH    CMR_NEURO_SEIZ   CMR_OBESE       CMR_PARALYSIS    CMR_PERIVASC     CMR_PSYCHOSES    CMR_PULMCIRC
      CMR_RENLFL_MOD   CMR_RENLFL_SEV   CMR_THYROID_HYPO CMR_THYROID_OTH CMR_ULCER_PEPTIC CMR_VALVE        CMR_WGHTLOSS  ;
    TITLE3 'Means of Comorbidity Variables';
RUN;






