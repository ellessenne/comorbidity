### R script for testing

## Load libraries
devtools::load_all()

dt <- data.frame(
  `Enc ID` = 1234,
  DxCode = "N390"
)
comorbidity(dt, id = "Enc ID", code = "DxCode", icd = "icd10", score = "charlson", assign0 = F)
