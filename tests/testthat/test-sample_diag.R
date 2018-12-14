context("sample_diag")

test_that("sample_diag returns an error if its 'n' argument is a string", {
  expect_error(
    sample_diag(n = "1")
  )
})

test_that("sample_diag returns an error if its 'n' argument is a boolean", {
  expect_error(
    sample_diag(n = TRUE)
  )
})

test_that("sample_diag returns an error if its 'n' argument is not of length one", {
  expect_error(
    sample_diag(n = 1:3)
  )
})

test_that("sample_diag returns an error if version is not 'ICD10_2009', 'ICD10_2011', 'ICD9_2015'", {
  expect_error(
    sample_diag(version = "2010")
  )
})

test_that("sample_diag returns an error if version is not a single string", {
  expect_error(
    sample_diag(version = c("ICD10_2009", "ICD10_2011"))
  )
  expect_error(
    sample_diag(version = 2011)
  )
  expect_error(
    sample_diag(version = TRUE)
  )
})

test_that("sample_diag returns a string vector", {
  expect_type(
    sample_diag(),
    type = "character"
  )
})

test_that("sample_diag returns a vector of appropriate length", {
  expect_length(
    sample_diag(n = 1),
    n = 1
  )
  expect_length(
    sample_diag(n = 5),
    n = 5
  )
  expect_length(
    sample_diag(n = 10),
    n = 10
  )
  expect_length(
    sample_diag(n = 100),
    n = 100
  )
  expect_length(
    sample_diag(n = 1000),
    n = 1000
  )
})

test_that("sample_diag works fine with either versions", {
  expect_type(
    sample_diag(version = "ICD10_2009"),
    type = "character"
  )
  expect_type(
    sample_diag(version = "ICD10_2011"),
    type = "character"
  )
  expect_type(
    sample_diag(version = "ICD9_2015"),
    type = "character"
  )
})
