### R script for testing

## Load libraries
devtools::load_all()

dt <- data.frame(
  `Enc ID` = 1234,
  DxCode = "N390"
)

# Testing the AHRQ Charlson
#comorbidity(dt, id = "Enc ID", code = "DxCode", icd = "icd10", score = "charlson", assign0 = F)

# Testing the AHRQ 2022 Elixhauser version using 
# the data set derived from EDW using 
# the following SQL query:
# SELECT
#   enc.PatientAccountID,
#   CAST(enc.DischargeDTS AS DATE) AS DischargeDate,
#   enc.DischargeFiscalYearNBR,
#   enc.MSDRG,
#   dm.QuarterNBR,
#   dx.ICD10DiagnosisSEQ,
#   dx.ICD10DiagnosisCD,
#   dx.PresentOnAdmissionCD
# FROM PatientFinancials.EPSi.InpatientEncounter_BWH AS enc
# JOIN PatientFinancials.EPSi.EncounterICD10Diagnosis_BWH AS dx
#   ON enc.PatientAccountID = dx.PatientAccountID
# JOIN PatientFinancials.AnalyticsDM.Quarter AS dm
#   ON enc.DischargeFiscalMonthNBR = dm.FiscalMonthNBR
# JOIN PatientFinancials.EPSi.InpatientEncounterWithExtended_BWH ext
#   ON ext.PatientAccountID = enc.PatientAccountID
# WHERE enc.DischargeFiscalYearNBR = 2021
#   AND ext.RatePayerCD = 'MCARE'

# Importing the data resulting from the above SQL query in 
# R data frame "comorbidity_test_dataset"

elixhauser_2022_comorb_calculation_results <- comorbidity(
  comorbidity_test_dataset,
  id = 'PatientAccountID',
  code = 'ICD10DiagnosisCD',
  score = "elixhauser",
  assign0 = FALSE,
  icd = "icd10",
  factorise = FALSE,
  labelled = TRUE,
  tidy.codes = TRUE,
  drg = NULL,
  icd_rank = 'ICD10DiagnosisSEQ',
  poa = 'PresentOnAdmissionCD',
  year = 'DischargeFiscalYearNBR',
  quarter = 'QuarterNBR',
  icd10cm_vers = 39
)
