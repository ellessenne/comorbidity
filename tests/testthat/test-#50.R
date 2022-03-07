context("issue #50")

# Repeat this tests 10 times with new random simulated data every time
for (i in seq(10)) {
  x <- data.frame(
    id = 1,
    code = sample_diag(10),
    stringsAsFactors = FALSE
  )
  xa <- data.frame(id = 1, code = NA_character_)
  xm <- rbind(x, xa)
  xa2 <- data.frame(id = 2, code = NA_character_)
  xm2 <- rbind(xm, xa2)

  test_that("missing values are dealt with properly (data.frame input)", {
    # x and xm should give the same results
    expect_equal(
      object = comorbidity(x = xm, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE),
      expected = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    )
  })

  test_that("error if only missing data (data.frame input)", {
    # Error if only missing data
    expect_error(object = comorbidity(x = xa, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE), regexp = "No non-missing data")
  })

  test_that("if a subject has only missing, all comorbidities are zero (data.frame input)", {
    # Error if only missing data
    c <- comorbidity(x = xm2, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    expect_true(object = all(c[c$id == 2, -1] == 0))
  })

  data.table::setDT(x)
  data.table::setDT(xm)
  data.table::setDT(xa)
  data.table::setDT(xm2)

  test_that("missing values are dealt with properly (data.table input)", {
    # x and xm should give the same results
    expect_equal(
      object = comorbidity(x = xm, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE),
      expected = comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    )
  })

  test_that("error if only missing data (data.table input)", {
    # Error if only missing data
    expect_error(object = comorbidity(x = xa, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE), regexp = "No non-missing data")
  })

  test_that("if a subject has only missing, all comorbidities are zero (data.frame input)", {
    # Error if only missing data
    c <- comorbidity(x = xm2, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    expect_true(object = all(c[c$id == 2, -1] == 0))
  })
}
