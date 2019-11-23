### R script for testing

## Load libraries
devtools::load_all()
library(data.table)

dt <- data.frame(
  EncID = 1234,
  DxCode = "N390"
)
comorbidity(dt, id = "EncID", code = "DxCode", icd = "icd10", score = "charlson", assign0 = F)

dt <- data.table(
  EncID = 1234,
  DxCode = "N390"
)
comorbidity(dt, id = "EncID", code = "DxCode", icd = "icd10", score = "charlson", assign0 = F, tidy.codes = T)
