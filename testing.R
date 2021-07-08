devtools::load_all()

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

xa <- x[[code]]
addd <- sample(x = seq(length(xa)), size = 1000)
xa[addd] <- paste0(".", xa[addd])

bm <- bench::mark(
  "gsub" = gsub(pattern = "[^[:alnum:]]", x = xa, replacement = ""),
  "stri_replace_all_regex" = stringi::stri_replace_all_regex(str = xa, pattern = "[^[:alnum:]]", replacement = ""),
  "stri_replace_all_charclass" = stringi::stri_replace_all_charclass(str = xa, pattern = "[^a-zA-Z0-9]", replacement = ""),
  relative = TRUE,
  iterations = 10
)

autoplot(bm)
