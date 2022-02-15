
# Download file
download.file(
  url = "https://www.hcup-us.ahrq.gov/toolssoftware/comorbidityicd10/ElixhauserComorbidity_v2021-1.zip",
  destfile = "AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/ElixhauserComorbidity_v2021-1.zip"
)
# Unzip
unzip("AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/ElixhauserComorbidity_v2021-1.zip",
      exdir = 'AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/ElixhauserComorbidity_v2021-1')

# Get raw SAS code line-by-line
raw_format = readLines(
  "AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/ElixhauserComorbidity_v2021-1/Comorb_ICD10CM_Format_v2021-1.sas"
  )

# Remove quotes, commas, and whitespace
trim_format = trimws(gsub(',', '', gsub('"', "", raw_format)))
# Remove 'proc' lines
trim_format = trim_format[!grepl('Proc', trim_format)]
# Remove 'run' lines
trim_format = trim_format[!grepl(';', trim_format)]
# Remove 'other' lines
trim_format = trim_format[!grepl('other', trim_format)]

# Separate vector by blank line
format_list = split(trim_format[trim_format!=''],
      cumsum(trim_format=="")[trim_format!=''])

# Remove extraneous
format_list = format_list[3:length(format_list)] # Header stuff

# Split into value groups
new_values = unlist(
  lapply(format_list,
       function(x) {
         any(grepl('Value \\$', x))
       })
  )

ElixhauserAHRQ2021Map = sapply(1:max(cumsum(new_values)),
       function(x){
         format_list[cumsum(new_values)==x]
       })

# Name the value groups
names(ElixhauserAHRQ2021Map) = unlist(
  lapply(ElixhauserAHRQ2021Map,
       function(x){
         strsplit(x[[1]][1], '\\$')[[1]][2]
       })
)

# Drop 'value' elements in comfmt
ElixhauserAHRQ2021Map$comfmt = sapply(ElixhauserAHRQ2021Map$comfmt,
       function(x) x[!grepl('Value', x)])

# Get icd group names for comfmt
names(ElixhauserAHRQ2021Map$comfmt) = sapply(ElixhauserAHRQ2021Map$comfmt,
       function(x){
         strsplit(x[grepl(' = ', x)], ' = ')[[1]][2]
       })

# Drop ' = XXXX' from icd groups
ElixhauserAHRQ2021Map$comfmt = sapply(ElixhauserAHRQ2021Map$comfmt,
       function(x){
         x = sapply(x, function(x) {
           strsplit(x, ' = ')[[1]][1]
         })
         names(x) = NULL
         x
       })

# Drop " = 1" from poaxmpt and 'value' elements
poaxmpt_names = names(ElixhauserAHRQ2021Map)[grepl('poa', names(ElixhauserAHRQ2021Map))]
for (i in poaxmpt_names){
  # Drop " = 1"
  ElixhauserAHRQ2021Map[[i]] = unlist(
    lapply(
      strsplit(ElixhauserAHRQ2021Map[[i]][[1]],
               ' = '),
      function(x) {
        x[[1]][1]
      }
    )
  )

  # Drop 'Value' elements
  ElixhauserAHRQ2021Map[[i]] = ElixhauserAHRQ2021Map[[i]][!grepl(
    'Value', ElixhauserAHRQ2021Map[[i]])]
}

# Define and save final comorbidities in AHRQ format:
ElixhauserAHRQ2021Abbr = c(
  'AIDS',
  'ALCOHOL',
  'ANEMDEF',
  'ARTH',
  'BLDLOSS',
  'CANCER_LYMPH',
  'CANCER_LEUK',
  'CANCER_METS',
  'CANCER_NSITU',
  'CANCER_SOLID',
  'CBVD',
  'CHF',
  'COAG',
  'DEMENTIA',
  'DEPRESS',
  'DIAB_UNCX',
  'DIAB_CX',
  'DRUG_ABUSE',
  'HTN_CX',
  'HTN_UNCX',
  'LIVER_MLD',
  'LIVER_SEV',
  'LUNG_CHRONIC',
  'NEURO_MOVT',
  'NEURO_OTH',
  'NEURO_SEIZ',
  'OBESE',
  'PARALYSIS',
  'PERIVASC',
  'PSYCHOSES',
  'PULMCIRC',
  'RENLFL_MOD',
  'RENLFL_SEV',
  'THYROID_HYPO',
  'THYROID_OTH',
  'ULCER_PEPTIC',
  'VALVE',
  'WGHTLOSS'
)

# Define and save value labels (see Comorb_ICD10CM_Format_v2021-1.sas)
ElixhauserAHRQ2021Labels = c(
  'AIDS' = 'Acquired immune deficiency syndrome',
  'ALCOHOL' = 'Alcohol abuse',
  'ANEMDEF' = 'Deficiency anemias',
  'ARTH' = 'Arthropathies',
  'BLDLOSS' = 'Chronic blood loss anemia',
  'CANCER_LEUK' = 'Leukemia',
  'CANCER_LYMPH' = 'Lymphoma',
  'CANCER_METS' = 'Metastatic cancer',
  'CANCER_NSITU' = 'Solid tumor without metastasis, in situ',
  'CANCER_SOLID' = 'Solid tumor without metastasis, malignant',
  'CBVD' = 'Cerebrovascular disease',
  'CBVD_NPOA' = 'Cerebrovascular disease, not on admission',
  'CBVD_POA' = 'Cerebrovascular disease, on admission',
  'CBVD_SQLA' = 'Cerebrovascular disease, sequela',
  'CHF' = 'Congestive heart failure',
  'COAG' = 'Coagulopthy',
  'DEMENTIA' = 'Dementia',
  'DEPRESS' = 'Depression',
  'DIAB_CX' = 'Diabetes with chronic complications',
  'DIAB_UNCX' = 'Diabetes without chronic complications',
  'DRUG_ABUSE' = 'Drug abuse',
  'HTN_CX' = 'Hypertension, complicated',
  'HTN_UNCX' = 'Hypertension, uncomplicated',
  'LIVER_MLD' = 'Liver disease, mild',
  'LIVER_SEV' = 'Liver disease, moderate to severe',
  'LUNG_CHRONIC' = 'Chronic pulmonary disease',
  'NEURO_MOVT' = 'Neurological disorders affecting movement',
  'NEURO_OTH' = 'Other neurological disorders',
  'NEURO_SEIZ' = 'Seizures and epilepsy',
  'OBESE' = 'Obesity',
  'PARALYSIS' = 'Paralysis',
  'PERIVASC' = 'Peripheral vascular disease',
  'PSYCHOSES' = 'Psychoses',
  'PULMCIRC' = 'Pulmonary circulation disease',
  'RENLFL_MOD' = 'Renal failure, moderate',
  'RENLFL_SEV' = 'Renal failure, severe',
  'THYROID_HYPO' = 'Hypothyroidism',
  'THYROID_OTH' = 'Other thyroid disorders',
  'ULCER_PEPTIC' = 'Peptic ulcer disease x bleeding',
  'VALVE' = 'Valvular disease',
  'WGHTLOSS' = 'Weight loss'
)

ElixhauserAHRQ2021PreExclusion = c(
  "AIDS",
  "ALCOHOL",
  "ANEMDEF",
  "ARTH",
  "BLDLOSS",
  "CANCER_LYMPH",
  "CANCER_LEUK",
  "CANCER_METS",
  "CANCER_NSITU",
  "CANCER_SOLID",
  "CBVD_SQLA",
  "CBVD_POA",
  "CBVD_NPOA",
  "CBVD",
  "CHF",
  "COAG",
  "DEMENTIA",
  "DEPRESS",
  "DIAB_UNCX",
  "DIAB_CX",
  "DRUG_ABUSE",
  "HTN_CX",
  "HTN_UNCX",
  "LIVER_MLD",
  "LIVER_SEV",
  "LUNG_CHRONIC",
  "NEURO_MOVT",
  "NEURO_OTH",
  "NEURO_SEIZ",
  "OBESE",
  "PARALYSIS",
  "PERIVASC",
  "PSYCHOSES",
  "PULMCIRC",
  "RENLFL_MOD",
  "RENLFL_SEV",
  "THYROID_HYPO",
  "THYROID_OTH",
  "ULCER_PEPTIC",
  "VALVE",
  "WGHTLOSS"
)

# Save list of format objects
Elixhauser2021Formats = list(
  ElixhauserAHRQ2021Map = ElixhauserAHRQ2021Map,
  ElixhauserAHRQ2021Abbr = ElixhauserAHRQ2021Abbr,
  ElixhauserAHRQ2021Labels = ElixhauserAHRQ2021Labels,
  ElixhauserAHRQ2021PreExclusion = ElixhauserAHRQ2021PreExclusion
)

# Remove .zip file
file.remove(
  "AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/ElixhauserComorbidity_v2021-1.zip"
)

# Remove unzipped folder
unlink(
  'AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/ElixhauserComorbidity_v2021-1',
  recursive = T
)
