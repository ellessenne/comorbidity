# Simulate data with DRG


set.seed(1)
x <- data.frame(
  id = sample(1:15, size = 200, replace = TRUE),
  code = sample_diag(200),
  drg = formatC(sample.int(999, 200, replace=TRUE), width=3, flag="0"),
  stringsAsFactors = FALSE
)
x