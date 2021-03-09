reprex::reprex({
  library(comorbidity)

  set.seed(1)
  NNN <- 100
  nnn <- 3
  x <- data.frame(
    id = sample(nnn, size = NNN, replace = TRUE),
    code = sample_diag(NNN)
  )

  xx <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10", assign0 = FALSE)
  xx

  score(xx, weights = "vw", assign0 = FALSE)
  score(xx, assign0 = FALSE)
})



# TO DO:
# 1- ICD-10-AM algorithm
# 2- ICD-10-SE algorithm
# 3- Quan 2011 weights
# 4- Swiss weights
