context("issue #50")
x <- data.frame(
  id = 1,
  code = sample_diag(10),
  stringsAsFactors = FALSE
)
xa <- data.frame(id = 1, code = NA_character_)
xm <- rbind(x, xa)

test_that("missing values are dealt with properly (data.frame input)", {
  # x and xm should give the same results
  expect_equal(
    object = comorbidity(x = xm, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE),
    expected = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  )
})

test_that("error if only missing data (data.frame input)", {
  # Error if only missing data
  expect_error(object = comorbidity(x = xa, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE))
})

data.table::setDT(x)
data.table::setDT(xm)
data.table::setDT(xa)

test_that("missing values are dealt with properly (data.table input)", {
  # x and xm should give the same results
  expect_equal(
    object = comorbidity(x = xm, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE),
    expected = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  )
})

test_that("error if only missing data (data.table input)", {
  # Error if only missing data
  expect_error(object = comorbidity(x = xa, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE))
})
