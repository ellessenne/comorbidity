### R script for testing

## Load libraries
library(comorbidity)
library(data.table)
library(tictoc)

## User function to replace factor levels using regex matching
### 'replace' must be a named list of regex codes, unmatched codes are dropped.
xfactor <- function(x, replace) {
  x <- factor(x)
  levels_tmp <- levels(x)
  for (i in seq_along(replace)) {
    levels_tmp[grepl(replace[i], levels_tmp)] <- names(replace)[i]
  }
  levels(x) <- levels_tmp
  x <- factor(x, levels = names(regex))
}

## Create example dataset
### Number of patients
n_ids <- 1000000
### Average number of codes per patient
n_codes <- 50

set.seed(1)
dfr <- data.frame(
  id = sample(1:n_ids, size = n_ids * n_codes, replace = TRUE),
  code = sample_diag(n_ids * n_codes),
  stringsAsFactors = FALSE
)

dfr <- dfr[order(dfr$id), ]

### Set options
id <- "id"
code <- "code"
score <- "charlson"
icd <- "icd10"
regex <- comorbidity:::lofregex[[score]][[icd]]

## Using current scoring algorithm
tictoc::tic()
### Split by ID
x1 <- utils::unstack(dfr, form = stats::as.formula(paste(code, id, sep = "~")))
### Run scoring algorithm
x1 <- comorbidity:::.score(x1, id = id, score = score, icd = icd, parallel = TRUE, mc.cores = 4)
x1[, -1] <- lapply(x1[, -1], as.integer)
tictoc::toc()

## New algorithm using base R
x2 <- dfr
tictoc::tic()
x2$code_f <- xfactor(x = x2[, code], replace = regex)
x2 <- unique(x2[, c(id, "code_f")])
x2 <- reshape2::dcast(x2, id ~ code_f, length, value.var = "code_f", fill = 0)
x2$`NA` <- NULL
x2[, id] <- as.character(x2[, id])
x2[, -1] <- lapply(x2[, -1], as.integer)
tictoc::toc()

identical(x1, x2)

## A further gain of speed using the data.table package
x3 <- dfr

tictoc::tic()
setDT(x3)
x3[, code_f := xfactor(x3[, code], regex)]
x3 <- dcast.data.table(unique(x3[, .(id, code_f, value = 1L)]), id ~ code_f, fill = 0)
x3[, `NA` := NULL]
x3[, id := as.character(id)]
setDF(x3)
tictoc::toc()

identical(x1, x3)

## Base approach
x4 <- dfr

tictoc::tic()
### Convert code to factor and replace codes with comorbidity names
x4$code_f <- xfactor(x = x4[, code], replace = regex)

### Drop records without any comorbidities and collapse duplicate comorbidities.
x4_w <- unique(x4[!is.na(x4$code_f), c(id, "code_f")])

### Reshape data wide, correct order and names of comorbidity variables
x4_w <- x4_w[order(x4_w[, id]), ]
x4_w$flag <- 1L
x4_w <- reshape(x4_w, idvar = id, timevar = "code_f", direction = "wide", sep = "_")
names(x4_w) <- gsub("flag_", "", names(x4_w))
x4_w <- x4_w[, c(id, names(regex))]

### Add back in records without any comorbidities, set NA values to 0.
x4 <- merge(unique(x4[, id, drop = FALSE]), x4_w, by = id, all.x = TRUE)
x4[is.na(x4)] <- 0L

### Change id variable to character (to match current output)
x4[, id] <- as.character(x4[, id])

tictoc::toc()

identical(x1, x4)
