devtools::load_all()
library(tidyverse)

set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  stringsAsFactors = FALSE
)

# Charlson score based on ICD-10 diagnostic codes:
x1 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)

x2 <- x1 %>%
  mutate(score = score(x = ., weights = "charlson", assign0 = FALSE))

attributes(x1)
attributes(x2)

library(devtools)
install_version("dplyr", version = "1.0.6", repos = "http://cran.us.r-project.org")

library(tidyverse)
library(comorbidity)
#> This is {comorbidity} version 1.0.0.
#> A lot has changed since the last release on CRAN, please check-out breaking changes here:
#> -> https://ellessenne.github.io/comorbidity/articles/C-changes.html


# Charlson score based on ICD-10 diagnostic codes:
reprex::reprex({
  library(comorbidity)
  set.seed(1)
  x <- data.frame(
    id = sample(1:15, size = 200, replace = TRUE),
    code = sample_diag(200),
    stringsAsFactors = FALSE
  )
  x1 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  x1$score <- score(x = x1, weights = "charlson", assign0 = FALSE)
  attributes(x1)
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
