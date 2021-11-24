
library(dplyr)

# Download file
download.file(url = "https://www.hcup-us.ahrq.gov/toolssoftware/comorbidityicd10/CMR-Reference-File-v2022-1.xlsx",
              destfile = "AHRQ-Elixhauser/sas-parse/icd10cm_2022_1/CMR-Reference-File-v2022-1.xlsx")

# Import data stored in tab "DX_to_Comorb_Mapping"
elix_ref_2022 <-
  readxl::read_excel("CMR-Reference-File-v2022-1.xlsx",
                     sheet = "DX_to_Comorb_Mapping",
                     skip = 1)

elix_ref_2022_refined <-
  elix_ref_2022 %>% select(-c("ICD-10-CM Code Description", "# Comorbidities"))

comrb_name <- colnames(elix_ref_2022_refined)

map_list2022 <- list()
for (i in 2:dim(elix_ref_2022_refined)[2]) {
  comorb_icd <-
    elix_ref_2022_refined[, c(1, i)] %>% 
    filter(.[[2]] == 1) %>% 
    pull(`ICD-10-CM Diagnosis`)
  colname <- comrb_name[i]
  tmp <- list(comorb_icd)
  map_list2022[colname] <- tmp
}

# Import data stored in tab "Comorbidity_Measures"
elix_ref_poa_2022 <- readxl::read_excel("CMR-Reference-File-v2022-1.xlsx", 
                                        sheet = "Comorbidity_Measures", 
                                        skip = 1) %>%
  filter(.[[3]] == "Yes")

poa_yes <- c(
  "ANEMDEF",
  "BLDLOSS",
  "CBVD", 
  "CBVD_POA",
  "CBVD_SQLA",
  "COAG",
  "HF",
  "LIVER_MLD",
  "LIVER_SEV",
  "NEURO_MOVT",
  "NEURO_OTH",
  "NEURO_SEIZ",
  "PARALYSIS",
  "PSYCHOSES",
  "PULMCIRC",
  "RENLFL_MOD",
  "RENLFL_SEV",
  "ULCER_PEPTIC",
  "VALVE",
  "WGHTLOSS"
)

poaxmpt_v39fmt <- c()
for(i in 1:length(poa_yes)){
  poaxmpt_v39fmt  <- c(poaxmpt_v39fmt, map_list2022[[poa_yes[i]]])
}

# Create a list named "ElixhauserAHRQ2022Map" 
# poaxmpt_v33fmt through poaxmpt_v38fmt are imported 
# from "ElixhauserAHRQ2021Map" available under "Elixhauser2021Formats" 
ElixhauserAHRQ2022Map <- list(
  comfmt = map_list2022,
  poaxmpt_v33fmt = Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v33fmt,
  poaxmpt_v34fmt = Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v34fmt,
  poaxmpt_v35fmt = Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v35fmt,
  poaxmpt_v36fmt = Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v36fmt,
  poaxmpt_v37fmt = Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v37fmt,
  poaxmpt_v38fmt = Elixhauser2021Formats$ElixhauserAHRQ2021Map$poaxmpt_v38fmt,
  poaxmpt_v39fmt = poaxmpt_v39fmt
)

# Define and save PreExclusion comorbidities in AHRQ format:
# (see CMR_Mapping_Program_v2022-1.sas lines 132-136)
ElixhauserAHRQ2022PreExclusion <- c(
  "CMR_AIDS", 
  "CMR_ALCOHOL",     
  "CMR_ANEMDEF",      
  "CMR_AUTOIMMUNE", 
  "CMR_BLDLOSS",  
  "CMR_CANCER_LYMPH", 
  "CMR_CANCER_LEUK",  
  "CMR_CANCER_METS", 
  "CMR_CANCER_NSITU", 
  "CMR_CANCER_SOLID", 
  "CMR_CBVD_SQLA",   
  "CMR_CBVD_POA",     
  "CMR_CBVD_NPOA",  
  "CMR_CBVD",      
  "CMR_HF", 
  "CMR_COAG",  
  "CMR_DEMENTIA",     
  "CMR_DEPRESS",     
  "CMR_DIAB_UNCX", 
  "CMR_DIAB_CX",      
  "CMR_DRUG_ABUSE",  
  "CMR_HTN_CX",       
  "CMR_HTN_UNCX",   
  "CMR_LIVER_MLD", 
  "CMR_LIVER_SEV",    
  "CMR_LUNG_CHRONIC", 
  "CMR_NEURO_MOVT", 
  "CMR_NEURO_OTH",    
  "CMR_NEURO_SEIZ",  
  "CMR_OBESECMR_PARALYSIS",  
  "CMR_PERIVASC",  
  "CMR_PSYCHOSES",    
  "CMR_PULMCIRC",     
  "CMR_RENLFL_MOD",  
  "CMR_RENLFL_SEV",
  "CMR_THYROID_HYPO", 
  "CMR_THYROID_OTH", 
  "CMR_ULCER_PEPTIC", 
  "CMR_VALVE",      
  "CMR_WGHTLOSS"
)

# Define and save final comorbidities in AHRQ format:
ElixhauserAHRQ2022Abbr = c(
  "CMR_AIDS"         = 'Acquired immune deficiency syndrome', 
  "CMR_ALCOHOL"      = 'Alcohol abuse',    
  "CMR_ANEMDEF"      = 'Deficiency anemias',      
  "CMR_AUTOIMMUNE"   = 'Autoimmune conditions',
  "CMR_BLDLOSS"      = 'Chronic blood loss anemia',   
  "CMR_CANCER_LEUK"  = 'Leukemia',
  "CMR_CANCER_LYMPH" = 'Lymphoma',
  "CMR_CANCER_METS"  = 'Metastatic cancer',
  "CMR_CANCER_NSITU" = 'Solid tumor without metastasis, in situ',
  "CMR_CANCER_SOLID" = 'Solid tumor without metastasis, malignant',
  "CMR_CBVD"         = 'Cerebrovascular disease',
  "CMR_CBVD_NPOA"    = 'Cerebrovascular disease, not on admission',
  "CMR_CBVD_POA"     = 'Cerebrovascular disease, on admission',
  "CMR_CBVD_SQLA"    = 'Cerebrovascular disease, sequela',
  "CMR_HF"           = 'Heart failure',
  "CMR_COAG"         = 'Coagulopathy',
  "CMR_DEMENTIA"     = 'Dementia',
  "CMR_DEPRESS"      = 'Depression',
  "CMR_DIAB_CX"      = 'Diabetes with chronic complications',
  "CMR_DIAB_UNCX"    = 'Diabetes without chronic complications',
  "CMR_DRUG_ABUSE"   = 'Drug abuse',
  "CMR_HTN_CX"       = 'Hypertension, complicated', 
  "CMR_HTN_UNCX"     = 'Hypertension, uncomplicated',
  "CMR_LIVER_MLD"    = 'Liver disease, mild',
  "CMR_LIVER_SEV"    = 'Liver disease, moderate to severe',
  "CMR_LUNG_CHRONIC" = 'Chronic pulmonary disease',
  "CMR_NEURO_MOVT"   = 'Neurological disorders affecting movement',
  "CMR_NEURO_OTH"    = 'Other neurological disorders', 
  "CMR_NEURO_SEIZ"   = 'Seizures and epilepsy',            
  "CMR_OBESE"        = 'Obesity',    
  "CMR_PARALYSIS"    = 'Paralysis',
  "CMR_PERIVASC"     = 'Peripheral vascular disease',
  "CMR_PSYCHOSES"    = 'Psychoses',
  "CMR_PULMCIRC"     = 'Pulmonary circulation disease',    
  "CMR_RENLFL_MOD"   = 'Renal failure, moderate',
  "CMR_RENLFL_SEV"   = 'Renal failure, severe', 
  "CMR_THYROID_HYPO" = 'Hypothyroidism',
  "CMR_THYROID_OTH"  = 'Other thyroid disorders',
  "CMR_ULCER_PEPTIC" = 'Peptic ulcer disease x bleeding',     
  "CMR_VALVE"        = 'Valvular disease',
  "CMR_WGHTLOSS"     = 'Weight loss'  
  )

# Define and save value labels 
# (see Comorb_ICD10CM_Format_v2022-1.sas)
ElixhauserAHRQ2022Labels = c(
  'CMR_AIDS' = 'Acquired immune deficiency syndrome',
  'CMR_ALCOHOL' = 'Alcohol abuse',
  'CMR_ANEMDEF' = 'Deficiency anemias',
  'CMR_AUTOIMMUNE' = 'Autoimmune conditions',
  'CMR_BLDLOSS' = 'Chronic blood loss anemia',
  'CMR_CANCER_LEUK' = 'Leukemia',
  'CMR_CANCER_LYMPH' = 'Lymphoma',
  'CMR_CANCER_METS' = 'Metastatic cancer',
  'CMR_CANCER_NSITU' = 'Solid tumor without metastasis, in situ',
  'CMR_CANCER_SOLID' = 'Solid tumor without metastasis, malignant',
  'CMR_CBVD' = 'Cerebrovascular disease',
  'CMR_COAG' = 'Coagulopthy',
  'CMR_DEMENTIA' = 'Dementia',
  'CMR_DEPRESS' = 'Depression',
  'CMR_DIAB_CX' = 'Diabetes with chronic complications',
  'CMR_DIAB_UNCX' = 'Diabetes without chronic complications',
  'CMR_DRUG_ABUSE' = 'Drug abuse',
  'CMR_HF' = 'Heart failure', 
  'CMR_HTN_CX' = 'Hypertension, complicated',
  'CMR_HTN_UNCX' = 'Hypertension, uncomplicated',
  'CMR_LIVER_MLD' = 'Liver disease, mild',
  'CMR_LIVER_SEV' = 'Liver disease, moderate to severe',
  'CMR_LUNG_CHRONIC' = 'Chronic pulmonary disease',
  'CMR_NEURO_MOVT' = 'Neurological disorders affecting movement',
  'CMR_NEURO_OTH' = 'Other neurological disorders',
  'CMR_NEURO_SEIZ' = 'Seizures and epilepsy',
  'CMR_OBESE' = 'Obesity',
  'CMR_PARALYSIS' = 'Paralysis',
  'CMR_PERIVASC' = 'Peripheral vascular disease',
  'CMR_PSYCHOSES' = 'Psychoses',
  'CMR_PULMCIRC' = 'Pulmonary circulation disease',
  'CMR_RENLFL_MOD' = 'Renal failure, moderate',
  'CMR_RENLFL_SEV' = 'Renal failure, severe',
  'CMR_THYROID_HYPO' = 'Hypothyroidism',
  'CMR_THYROID_OTH' = 'Other thyroid disorders',
  'CMR_ULCER_PEPTIC' = 'Peptic ulcer disease x bleeding',
  'CMR_VALVE' = 'Valvular disease',
  'CMR_WGHTLOSS' = 'Weight loss'
)

# Save list of format objects
Elixhauser2022Formats <-
  list(
    ElixhauserAHRQ2022Abbr = ElixhauserAHRQ2022Abbr,
    ElixhauserAHRQ2022Labels = ElixhauserAHRQ2022Labels,
    ElixhauserAHRQ2022Map = ElixhauserAHRQ2022Map,
    ElixhauserAHRQ2022PreExclusion = ElixhauserAHRQ2022PreExclusion
  )

saveRDS(Elixhauser2022Formats, 
        file = 'AHRQ-Elixhauser/sas-formats/icd10cm_2022_1/Elixhauser2022Formats.Rds')















