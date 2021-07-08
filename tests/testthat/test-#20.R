context("issue #20")

test_that("comorbidity works no matter what the name of the id variable is", {
  x <- data.frame(
    id = sample(1:15, size = 200, replace = TRUE),
    code = sample_diag(200),
    stringsAsFactors = FALSE
  )
  tgt <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = TRUE, tidy.codes = TRUE)
  colnames(x) <- c("testid", "code")
  obj <- comorbidity(x = x, id = "testid", code = "code", map = "charlson_icd10_quan", assign0 = TRUE, tidy.codes = TRUE)
  expect_equal(object = obj, expected = tgt, check.attributes = FALSE)
  # with a randomly generated name:
  rdmname <- paste(sample(x = LETTERS, size = 20, replace = TRUE), collapse = "")
  colnames(x) <- c(rdmname, "code")
  rdm <- comorbidity(x = x, id = rdmname, code = "code", map = "charlson_icd10_quan", assign0 = TRUE, tidy.codes = TRUE)
  expect_equal(object = rdm, expected = tgt, check.attributes = FALSE)
})

test_that("comorbidity works no matter what the name of the code variable is", {
  x <- data.frame(
    id = sample(1:15, size = 200, replace = TRUE),
    code = sample_diag(200),
    stringsAsFactors = FALSE
  )
  tgt <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = TRUE, tidy.codes = TRUE)
  colnames(x) <- c("id", "diag")
  obj <- comorbidity(x = x, id = "id", code = "diag", map = "charlson_icd10_quan", assign0 = TRUE, tidy.codes = TRUE)
  expect_equal(object = obj, expected = tgt, check.attributes = FALSE)
  # with a randomly generated name:
  rdmname <- paste(sample(x = LETTERS, size = 20, replace = TRUE), collapse = "")
  colnames(x) <- c("id", rdmname)
  rdm <- comorbidity(x = x, id = "id", code = rdmname, map = "charlson_icd10_quan", assign0 = TRUE, tidy.codes = TRUE)
  expect_equal(object = rdm, expected = tgt, check.attributes = FALSE)
})
