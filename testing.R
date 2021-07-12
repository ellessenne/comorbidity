library(comorbidity)
library(ggplot2)
library(ggbeeswarm)
library(tidyr)

set.seed(1)
x <- data.frame(
  id = sample(seq(1e5), size = 1e7, replace = TRUE),
  code = sample_diag(1e7),
  stringsAsFactors = FALSE
)

addd <- sample(x = seq(nrow(x)), size = 5e4)
x$code[addd] <- paste0(".", x$code[addd])

#
id <- "id"
code <- "code"
map <- "elixhauser_icd10_quan"
assign0 <- FALSE
labelled <- FALSE
tidy.codes <- TRUE

bm <- bench::mark(
  "new" = comorbidity(x = x, id = id, code = code, map = map, assign0 = assign0, labelled = labelled, tidy.codes = tidy.codes, new = TRUE),
  "old" = comorbidity(x = x, id = id, code = code, map = map, assign0 = assign0, labelled = labelled, tidy.codes = tidy.codes, new = FALSE),
  iterations = 30
)
bm
autoplot(bm)
