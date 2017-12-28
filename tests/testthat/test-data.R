context("data")

test_that("loading data works", {
  data("icd10_2009", package = "charlson")
  expect_s3_class(object = icd10_2009, class = "data.frame")
  data("icd10_2011", package = "charlson")
  expect_s3_class(object = icd10_2011, class = "data.frame")
})