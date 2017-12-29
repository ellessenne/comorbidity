context("sample_diag_icd10")

test_that("sample_diag_icd10 returns an error if its 'n' argument is a string", {
  expect_error(
    sample_diag_icd10(n = "1")
  )
})

test_that("sample_diag_icd10 returns an error if its 'n' argument is a boolean", {
  expect_error(
    sample_diag_icd10(n = TRUE)
  )
})

test_that("sample_diag_icd10 returns an error if its 'n' argument is not of length one", {
  expect_error(
    sample_diag_icd10(n = 1:3)
  )
})

test_that("sample_diag_icd10 returns an error if version is not '2009' nor '2011'", {
  expect_error(
    sample_diag_icd10(version = "2010")
  )
})

test_that("sample_diag_icd10 returns an error if version is not a single string", {
  expect_error(
    sample_diag_icd10(version = c("2009", "2011"))
  )
  expect_error(
    sample_diag_icd10(version = 2011)
  )
  expect_error(
    sample_diag_icd10(version = TRUE)
  )
})

test_that("sample_diag_icd10 returns a string vector", {
  expect_type(
    sample_diag_icd10(),
    type = "character"
  )
})

test_that("sample_diag_icd10 returns a vector of appropriate length", {
  expect_length(
    sample_diag_icd10(n = 1),
    n = 1
  )
  expect_length(
    sample_diag_icd10(n = 5),
    n = 5
  )
  expect_length(
    sample_diag_icd10(n = 10),
    n = 10
  )
  expect_length(
    sample_diag_icd10(n = 100),
    n = 100
  )
  expect_length(
    sample_diag_icd10(n = 1000),
    n = 1000
  )
})

test_that("sample_diag_icd10 works fine with either versions", {
  expect_type(
    sample_diag_icd10(version = "2009"),
    type = "character"
  )
  expect_type(
    sample_diag_icd10(version = "2011"),
    type = "character"
  )
})