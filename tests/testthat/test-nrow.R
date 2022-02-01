context("'comorbidity' returns a df with the proper (expected) number of rows")

test_that("'comorbidity' returns a df with the proper (expected) number of rows under various settings", {
  for (i in seq(10)) {
    n <- sample(x = seq(50), size = 1)
    x <- data.frame(
      id = rep(seq(n), each = 10),
      code = sample_diag(n * 10),
      stringsAsFactors = FALSE
    )
    res <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE, tidy.codes = TRUE)
    expect_equal(object = nrow(res), expected = n)
    res <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE, tidy.codes = TRUE)
    expect_equal(object = nrow(res), expected = n)
    res <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_se", assign0 = FALSE, tidy.codes = TRUE)
    expect_equal(object = nrow(res), expected = n)
    res <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE, tidy.codes = TRUE)
    expect_equal(object = nrow(res), expected = n)
    res <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE, tidy.codes = TRUE)
    expect_equal(object = nrow(res), expected = n)
  }
})
