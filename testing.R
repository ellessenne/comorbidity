devtools::load_all()
library(bench)
library(ggplot2)
library(ggbeeswarm)

set.seed(1)
x <- data.frame(
  id = sample(seq(3e4), size = 3e6, replace = TRUE),
  code = sample_diag(3e6),
  stringsAsFactors = FALSE
)

addd <- sample(x = seq(nrow(x)), size = 3e4)
x$code[addd] <- paste0(".", x$code[addd])

bm <- bench::mark(
  "current" = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE, tidy.codes = TRUE),
  "stringi" = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE, stringi = TRUE, tidy.codes = TRUE),
  iterations = 20
)
autoplot(bm)
