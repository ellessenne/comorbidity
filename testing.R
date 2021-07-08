reprex::reprex({
  library(comorbidity)
  library(bench)
  library(ggplot2)
  library(ggbeeswarm)
  library(tidyr)

  set.seed(1)
  x <- data.frame(
    id = sample(seq(1e3), size = 1e5, replace = TRUE),
    code = sample_diag(1e5),
    stringsAsFactors = FALSE
  )

  addd <- sample(x = seq(nrow(x)), size = 5e3)
  x$code[addd] <- paste0(".", x$code[addd])

  bm <- bench::mark(
    "current" = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE, stringi = FALSE),
    "stringi" = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE, stringi = TRUE),
    iterations = 30
  )
  bm
}, venue = "gh")
