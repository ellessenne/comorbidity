context("issue #25")

test_that("comorbidity triggers a warning with non-syntactically valid names", {
  dt <- data.frame(
    `Enc ID` = 1234,
    DxCode = "N390"
  )
  testthat::expect_warning(comorbidity(dt, id = "Enc ID", code = "DxCode", map = "charlson_icd10_quan", assign0 = FALSE))
})

test_that("comorbidity (when changing names) works equally", {
  dt <- data.frame(
    `Enc ID` = 1234,
    DxCode = "N390"
  )
  como <- suppressWarnings(comorbidity(dt, id = "Enc ID", code = "DxCode", map = "charlson_icd10_quan", assign0 = FALSE))
  dt.ok <- data.frame(
    EncID = 1234,
    DxCode = "N390"
  )
  como.ok <- comorbidity(dt.ok, id = "EncID", code = "DxCode", map = "charlson_icd10_quan", assign0 = FALSE)
  testthat::expect_equal(object = como[, -1], expected = como.ok[, -1])
})

# Other tests that I had added to test-comorbidity.R
test_that("expect warnings when using not syntactically valid names", {
  dt <- data.frame(
    `Enc ID` = 1234,
    DxCode = "N390"
  )
  expect_warning(comorbidity(dt, id = "Enc ID", code = "DxCode", map = "charlson_icd10_quan", assign0 = FALSE))
  dt <- data.frame(
    `Enc ID` = 1234,
    DxCode = "N390",
    check.names = FALSE
  )
  expect_warning(comorbidity(dt, id = "Enc ID", code = "DxCode", map = "charlson_icd10_quan", assign0 = FALSE))
  dt <- data.frame(
    Enc.ID = 1234,
    DxCode = "N390"
  )
  expect_warning(comorbidity(dt, id = "Enc ID", code = "DxCode", map = "charlson_icd10_quan", assign0 = FALSE))
  dt <- data.frame(
    EncID = 1234,
    `Dx Code` = "N390"
  )
  expect_warning(comorbidity(dt, id = "EncID", code = "Dx Code", map = "charlson_icd10_quan", assign0 = FALSE))
  dt <- data.frame(
    EncID = 1234,
    Dx.Code = "N390"
  )
  expect_warning(comorbidity(dt, id = "EncID", code = "Dx Code", map = "charlson_icd10_quan", assign0 = FALSE))
})
