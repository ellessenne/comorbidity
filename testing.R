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
set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  stringsAsFactors = FALSE
)
x$id <- as.character(x$id)
comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)


set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  stringsAsFactors = FALSE
)
x$id <- as.character(x$id)
x$code[x$id == "1"] <- NA_character_
id <- "id"
code <- "code"
map <- "charlson_icd10_quan"
assign0 <- FALSE
labelled <- TRUE
tidy.codes <- TRUE

# E-mail
library(reprex)
reprex({
  library(comorbidity)
  df <- data.frame(
    id = 1,
    mi = 1,
    chf = 0,
    pvd = 0,
    cevd = 0,
    dementia = 0,
    cpd = 0,
    rheumd = 0,
    pud = 0,
    mld = 0,
    diab = 0,
    diabwc = 1,
    hp = 1,
    rend = 0,
    canc = 0,
    msld = 0,
    metacanc = 0,
    aids = 0
  )
  score(x = df)

  class(df) <- c("comorbidity", class(df))
  attr(df, "map") <- "charlson_icd10_quan"
  score(x = df, assign0 = FALSE)
  score(x = df, weights = "quan", assign0 = FALSE)

  df$mi <- NULL
  score(x = df, assign0 = FALSE)
})
