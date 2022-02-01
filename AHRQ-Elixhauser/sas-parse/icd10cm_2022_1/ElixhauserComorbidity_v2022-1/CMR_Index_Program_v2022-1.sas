/******************************************************************/
/* Title:       ELIXHAUSER COMORBIDITY SOFTWARE REFINED           */
/*              FOR ICD-10-CM INDEX PROGRAM                       */
/*                                                                */
/* Program:     CMR_Index_Program_v2022-1.SAS                     */
/*                                                                */
/* Diagnoses:   v2022-1 of the index is compatible v2022-1        */
/*              of the Elixhauser Comorbidity Software Refined    */
/*              for ICD-10-CM.                                    */
/*                                                                */
/* Description: This SAS program calculates the Elixhauser        */
/*              Comorbidity Software mortality and readmission    */
/*              indices. The program assumes all 38 data elements */ 
/*              for the comorbidity measures (starting with the   */ 
/*              prefix CMR_) are available on the input file and  */
/*              were assigned using indicators that the diagnosis */
/*              was present on admission                          */
/*                                                                */
/* Note:	    The SAS programs CMR_Format_Program_v2022-1 and   */
/*              CMR_Mapping_Program_v2022-1 must be run prior     */
/*	            to running this index program.                    */
/*                                                                */
/* Output:	    This program appends the two comorbidity indices  */
/*	            to the input SAS file.  The data elements are:    */
/*                 CMR_Index_Mortality and CMR_Index_Readmission. */
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
LIBNAME  IN1     'c:\sasdata\';                    * Location of input discharge data.   <===USER MUST MODIFY;
LIBNAME  OUT1    'c:\sasdata\';                    * Location of output data.             <===USER MUST MODIFY;

/*********************************************/
/*   SPECIFY INPUT FILE CHARACTERISTICS      */
/*********************************************/ 
* Specify the number of observations to use from the 
  input dataset.  Use MAX to use all observations and
  use a smaller value for testing the program;             %LET OBS = MAX;        *<===USER MAY MODIFY;

/*********************************************/
/*  NUMBER OF COMORBIDITY VARIABLES, v2022.1 */
/*********************************************/ 
* Number of comorbidity variables in v2022.1.  
  This assumes comorbidities were assigned using 
  present on admission indicators; 
  %Let    NUMcomorb_ = 38;            *<===DO NOT MODIFY;

/**********************************************/
/*          SPECIFY FILE NAMES                */
/**********************************************/
* Input SAS file member name;                               %Let CORE = YOUR_SAS_INPUT_FILE_HERE;     *<===USER MUST MODIFY;            
* Output SAS file member name;                              %Let OUT  = YOUR_SAS_OUTPUT_FILE_HERE;    *<===USER MUST MODIFY;


TITLE1 'Elixhauser Comorbidity Software Refined for ICD-10-CM Diagnoses';
TITLE2 'Assignment of In-Hospital Mortality and 30-Day Readmission Indices';


DATA OUT1.&OUT.;
   SET  IN1.&CORE ;

   Length
        CMR_Index_Readmission CMR_Index_Mortality 3; 

   LABEL
        CMR_Index_Readmission = 'Comorbidity index for risk of 30-day, all-cause readmission' 
        CMR_Index_Mortality   = 'Comorbidity index for risk of in-hospital mortality'     
        ;

   /***********************************************************/
   /*  Weights for calculating readmission index              */
   /***********************************************************/
   rwAIDS         =  5 ;       
   rwALCOHOL      =  3 ;
   rwANEMDEF      =  5 ;
   rwAUTOIMMUNE   =  2 ;
   rwBLDLOSS      =  2 ;
   rwCANCER_LEUK  = 10 ;
   rwCANCER_LYMPH =  7 ;
   rwCANCER_METS  = 11 ;
   rwCANCER_NSITU =  0 ;
   rwCANCER_SOLID =  7 ;
   rwCBVD         =  0 ;
   rwHF           =  7 ;
   rwCOAG         =  3 ;
   rwDEMENTIA     =  1 ;
   rwDEPRESS      =  2 ;
   rwDIAB_CX      =  4 ;
   rwDIAB_UNCX    =  0 ;
   rwDRUG_ABUSE   =  6 ;
   rwHTN_CX       =  0 ;
   rwHTN_UNCX     =  0 ;
   rwLIVER_MLD    =  3 ;
   rwLIVER_SEV    = 10 ;
   rwLUNG_CHRONIC =  4 ;
   rwNEURO_MOVT   =  1 ;
   rwNEURO_OTH    =  2 ;
   rwNEURO_SEIZ   =  5 ;
   rwOBESE        = -2 ;
   rwPARALYSIS    =  3 ;
   rwPERIVASC     =  1 ;
   rwPSYCHOSES    =  6 ;
   rwPULMCIRC     =  3 ;
   rwRENLFL_MOD   =  4 ;
   rwRENLFL_SEV   =  8 ;
   rwTHYROID_HYPO =  0 ;
   rwTHYROID_OTH  =  0 ;
   rwULCER_PEPTIC =  2 ;
   rwVALVE        =  0 ;
   rwWGHTLOSS     =  6 ;

   /***********************************************************/
   /*  Weights for calculating mortality index                */
   /***********************************************************/
   mwAIDS         = -4 ;
   mwALCOHOL      = -1 ;
   mwANEMDEF      = -3 ;
   mwAUTOIMMUNE   = -1 ;
   mwBLDLOSS      = -4 ;
   mwCANCER_LEUK  =  9 ;
   mwCANCER_LYMPH =  6 ;
   mwCANCER_METS  = 23 ;
   mwCANCER_NSITU =  0 ;
   mwCANCER_SOLID = 10 ;
   mwCBVD         =  5 ;
   mwHF           = 15 ;
   mwCOAG         = 15 ;
   mwDEMENTIA     =  5 ;
   mwDEPRESS      = -9 ;
   mwDIAB_CX      = -2 ;
   mwDIAB_UNCX    =  0 ;
   mwDRUG_ABUSE   = -7 ;
   mwHTN_CX       =  1 ;
   mwHTN_UNCX     =  0 ;
   mwLIVER_MLD    =  2 ;
   mwLIVER_SEV    = 17 ;
   mwLUNG_CHRONIC =  2 ;
   mwNEURO_MOVT   = -1 ;
   mwNEURO_OTH    = 23 ;
   mwNEURO_SEIZ   =  2 ;
   mwOBESE        = -7 ;
   mwPARALYSIS    =  4 ;
   mwPERIVASC     =  3 ;
   mwPSYCHOSES    = -9 ;
   mwPULMCIRC     =  4 ;
   mwRENLFL_MOD   =  3 ;
   mwRENLFL_SEV   =  8 ;
   mwTHYROID_HYPO = -3 ;
   mwTHYROID_OTH  = -8 ;
   mwULCER_PEPTIC =  0 ;
   mwVALVE        =  0 ;
   mwWGHTLOSS     = 14 ;

   /***********************************************************/
   /*      Arrays Used to Assign Final Indexes                */
   /***********************************************************/
   array cmvars(&NUMcomorb_) 	    CMR_AIDS       CMR_ALCOHOL      CMR_ANEMDEF      CMR_AUTOIMMUNE   CMR_BLDLOSS      CMR_CANCER_LEUK  CMR_CANCER_LYMPH CMR_CANCER_METS  CMR_CANCER_NSITU 
                   CMR_CANCER_SOLID CMR_CBVD       CMR_HF           CMR_COAG         CMR_DEMENTIA     CMR_DEPRESS      CMR_DIAB_CX      CMR_DIAB_UNCX    CMR_DRUG_ABUSE   CMR_HTN_CX       
                   CMR_HTN_UNCX     CMR_LIVER_MLD  CMR_LIVER_SEV    CMR_LUNG_CHRONIC CMR_NEURO_MOVT   CMR_NEURO_OTH    CMR_NEURO_SEIZ   CMR_OBESE        CMR_PARALYSIS    CMR_PERIVASC 
                   CMR_PSYCHOSES    CMR_PULMCIRC   CMR_RENLFL_MOD   CMR_RENLFL_SEV   CMR_THYROID_HYPO CMR_THYROID_OTH  CMR_ULCER_PEPTIC CMR_VALVE        CMR_WGHTLOSS      
					;

   array rwcms(&NUMcomorb_) 	rwAIDS       rwALCOHOL      rwANEMDEF      rwAUTOIMMUNE  rwBLDLOSS      rwCANCER_LEUK  rwCANCER_LYMPH rwCANCER_METS  rwCANCER_NSITU rwCANCER_SOLID
                    rwCBVD      rwHF         rwCOAG         rwDEMENTIA     rwDEPRESS     rwDIAB_CX      rwDIAB_UNCX    rwDRUG_ABUSE   rwHTN_CX       rwHTN_UNCX 
					rwLIVER_MLD rwLIVER_SEV  rwLUNG_CHRONIC rwNEURO_MOVT   rwNEURO_OTH   rwNEURO_SEIZ   rwOBESE        rwPARALYSIS    rwPERIVASC     rwPSYCHOSES   
					rwPULMCIRC  rwRENLFL_MOD rwRENLFL_SEV   rwTHYROID_HYPO rwTHYROID_OTH rwULCER_PEPTIC rwVALVE        rwWGHTLOSS      
					;

   array mwcms(&NUMcomorb_) 	mwAIDS       mwALCOHOL      mwANEMDEF      mwAUTOIMMUNE  mwBLDLOSS      mwCANCER_LEUK  mwCANCER_LYMPH mwCANCER_METS  mwCANCER_NSITU mwCANCER_SOLID
                    mwCBVD      mwHF         mwCOAG         mwDEMENTIA     mwDEPRESS     mwDIAB_CX      mwDIAB_UNCX    mwDRUG_ABUSE   mwHTN_CX       mwHTN_UNCX 
					mwLIVER_MLD mwLIVER_SEV  mwLUNG_CHRONIC mwNEURO_MOVT   mwNEURO_OTH   mwNEURO_SEIZ   mwOBESE        mwPARALYSIS    mwPERIVASC     mwPSYCHOSES   
					mwPULMCIRC  mwRENLFL_MOD mwRENLFL_SEV   mwTHYROID_HYPO mwTHYROID_OTH mwULCER_PEPTIC mwVALVE        mwWGHTLOSS      
					;

   array ricms(&NUMcomorb_)     riAIDS       riALCOHOL      riANEMDEF      riAUTOIMMUNE   riBLDLOSS      riCANCER_LEUK  riCANCER_LYMPH riCANCER_METS  riCANCER_NSITU riCANCER_SOLID
                    riCBVD      riHF         riCOAG         riDEMENTIA     riDEPRESS      riDIAB_CX      riDIAB_UNCX    riDRUG_ABUSE   riHTN_CX       riHTN_UNCX 
					riLIVER_MLD riLIVER_SEV  riLUNG_CHRONIC riNEURO_MOVT   riNEURO_OTH    riNEURO_SEIZ   riOBESE        riPARALYSIS    riPERIVASC     riPSYCHOSES   
					riPULMCIRC  riRENLFL_MOD riRENLFL_SEV   riTHYROID_HYPO riTHYROID_OTH  riULCER_PEPTIC riVALVE        riWGHTLOSS      
					;

   array micms(&NUMcomorb_)     miAIDS       miALCOHOL      miANEMDEF      miAUTOIMMUNE   miBLDLOSS      miCANCER_LEUK  miCANCER_LYMPH miCANCER_METS  miCANCER_NSITU miCANCER_SOLID
                    miCBVD      miHF         miCOAG         miDEMENTIA     miDEPRESS      miDIAB_CX      miDIAB_UNCX    miDRUG_ABUSE   miHTN_CX       miHTN_UNCX 
					miLIVER_MLD miLIVER_SEV  miLUNG_CHRONIC miNEURO_MOVT   miNEURO_OTH    miNEURO_SEIZ   miOBESE        miPARALYSIS    miPEmiVASC     miPSYCHOSES   
					miPULMCIRC  miRENLFL_MOD miRENLFL_SEV   miTHYROID_HYPO miTHYROID_OTH  miULCER_PEPTIC miVALVE        miWGHTLOSS      
					;

   *****Calculate readmission and mortality indices;
   do i = 1 to &NUMcomorb_;
      ricms[i]=cmvars[i]*rwcms[i];
      micms[i]=cmvars[i]*mwcms[i];
   end;

   CMR_Index_Readmission = sum(of ricms[*]);
   CMR_Index_Mortality   = sum(of micms[*]);

   ***drop all intermediate variables;
   drop rw: mw: ri: mi: i;
RUN;


/***********************************/
/*  Means of comorbidity variables */
/***********************************/  
PROC MEANS DATA=OUT1.&OUT.  N NMISS MEAN STD MIN MAX;
  VAR    CMR_Index_Readmission CMR_Index_Mortality ;
   TITLE3 'Means of Comorbidity Indices';
RUN;





