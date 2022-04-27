devtools::load_all()
library(profvis)

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

profvis::profvis({
  comorbidity(x = x, id = id, code = code, map = map, assign0 = assign0, labelled = labelled, tidy.codes = tidy.codes)
})

# #50:
set.seed(1)
x <- data.frame(
  id = 1,
  code = sample_diag(10),
  stringsAsFactors = FALSE
)
xa <- data.frame(id = 1:2, code = NA_character_)
xm <- rbind(x, xa)

library(data.table)
setDT(xm)

# Charlson score based on ICD-10 diagnostic codes:
comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
comorbidity(x = xm, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
comorbidity(x = xa, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)

reprex::reprex({
  library(comorbidity)
  library(tidyverse)
  set.seed(1)
  x <- data.frame(
    id = sample(1:15, size = 200, replace = TRUE),
    code = sample_diag(200),
    stringsAsFactors = FALSE
  )

  # Charlson score based on ICD-10 diagnostic codes:
  x1 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE) %>%
    score(x = ., weights = "charlson", assign0 = FALSE)
  attributes(x1)

  x1
})


# #55
devtools::load_all()

library(comorbidity)
set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  stringsAsFactors = FALSE
)
x$id <- as.character(x$id)
comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
