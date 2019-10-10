context("'comorbidity' returns a df with the proper (expected) number of rows")

test_that("comorbidity works no matter what the name of the id variable is", {
  for (i in seq(100)) {
    n <- sample(x = seq(100), size = 1)
    x <- data.frame(
      id = rep(seq(n), each = 10),
      code = sample_diag(n * 10),
      stringsAsFactors = FALSE
    )
    res <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = TRUE, tidy.codes = TRUE)
    expect_equal(object = nrow(res), expected = n)
  }
})
