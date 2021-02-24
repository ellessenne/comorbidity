### R script for testing
library(ggplot2)

# Load libraries
devtools::load_all()

set.seed(1)

NNN <- 100
nnn <- 20
x <- data.frame(
  id = sample(nnn, size = NNN, replace = TRUE),
  code = sample_diag(NNN),
  stringsAsFactors = FALSE
)

# Charlson score based on ICD-10 diagnostic codes:
x1 <- comorbidity(x = data.frame(id = 1, code = c("E100", "E102")), id = "id", code = "code", map = "charlson_icd10", assign0 = FALSE)
comorbidity(x = data.frame(id = 1, code = c("E100", "E102")), id = "id", code = "code", map = "charlson_icd10", assign0 = TRUE)
x2 <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10", assign0 = FALSE)

score(x1, assign0 = FALSE, weights = "charlson")
score(x1, assign0 = TRUE, weights = "charlson")
score(x2, assign0 = FALSE, weights = "vw")

# TO DO:
# 1- ICD-10-AM algorithm
# 2- ICD-10-SE algorithm
# 3- Quan 2011 weights
# 4- Swiss weights
