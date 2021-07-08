devtools::load_all()
library(bench)
library(ggplot2)
library(ggbeeswarm)

set.seed(1)
x <- data.frame(
  id = sample(seq(1e4), size = 1e6, replace = TRUE),
  code = sample_diag(1e6),
  stringsAsFactors = FALSE
)
id <- "id"
code <- "code"
map <- "charlson_icd10_quan"
assign0 <- FALSE
labelled <- TRUE
tidy.codes <- TRUE
regex <- lapply(X = .maps[[map]], FUN = .codes_to_regex)

xa <- x[[code]]
addd <- sample(x = seq(length(xa)), size = 1000)
xa[addd] <- paste0(".", xa[addd])

bm <- bench::mark(
  ".tidy" = .tidy(x = x, code = code),
  ".tidy2" = .tidy2(x = x, code = code),
  iterations = 20,
  relative = TRUE
)
autoplot(bm)

bm <- bench::mark(
  "grep" = grep(pattern = regex[[2]], x = x$code, value = TRUE),
  "stri_subset_regex" = stringi::stri_subset_regex(str = x$code, pattern = regex[[2]]),
  iterations = 20,
  relative = TRUE
)
autoplot(bm)
