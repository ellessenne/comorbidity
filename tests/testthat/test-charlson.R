context("charlson")

test_that("charlson returns an error if x is a vector", {
  x <- sample_diag(50)
  expect_error(
    charlson(x = x, id = "id", code = "code"))
})

test_that("charlson returns an error if x, id, code are not provided", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE)
  expect_error(
    charlson(x = x))
  expect_error(
    charlson(id = "id"))
  expect_error(
    charlson(code = "code"))
  expect_error(
    charlson(x = x, id = "id"))
  expect_error(
    charlson(x = x, code = "code"))
  expect_error(
    charlson(id = "id", code = "code"))
})

test_that("charlson returns an error if id, code not in x", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE)
  expect_error(
    charlson(x = x, id = "ID", code = "code"))
  expect_error(
    charlson(x = x, id = "id", code = "CODE"))
  expect_error(
    charlson(x = x, id = "ID", code = "CODE"))
})

test_that("charlson checks for its arguments properly", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE)
  expect_error(
    charlson(x = x, id = "id", code = "code", assign0 = 1))
  expect_error(
    charlson(x = x, id = "id", code = "code", assign0 = "1"))
  expect_error(
    charlson(x = x, id = "id", code = "code", factorise = 1))
  expect_error(
    charlson(x = x, id = "id", code = "code", factorise = "1"))
  expect_error(
    charlson(x = x, id = "id", code = "code", labelled = 1))
  expect_error(
    charlson(x = x, id = "id", code = "code", labelled = "1"))
  expect_error(
    charlson(x = x, id = "id", code = "code", tidy.codes = 1))
  expect_error(
    charlson(x = x, id = "id", code = "code", tidy.codes = "1"))
  expect_error(
    charlson(x = x, id = "id", code = "code", parallel = 1))
  expect_error(
    charlson(x = x, id = "id", code = "code", parallel = "1"))
  expect_error(
    charlson(x = x, id = "id", code = "code", mc.cores = "1"))
  expect_error(
    charlson(x = x, id = "id", code = "code", mc.cores = TRUE))
})

test_that("charlson returns a data.frame", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE)
  cs = charlson(x = x, id = "id", code = "code")
  expect_s3_class(cs, "data.frame")
})

test_that("charlson returns a data.frame with the correct number of rows", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE)
  cs <- charlson(x = x, id = "id", code = "code")
  expect_equal(nrow(cs), 5)
  x <- data.frame(
    id = sample(1:50, size = 10 * 50, replace = TRUE),
    code = sample_diag(10 * 50),
    stringsAsFactors = FALSE)
  cs <- charlson(x = x, id = "id", code = "code")
  expect_equal(nrow(cs), 50)
})

test_that("if labelled = TRUE, charlson returns variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE)
  cs <- charlson(x = x, id = "id", code = "code", labelled = TRUE)
  expect_false(is.null(attr(cs, "variable.labels")))
})

test_that("if labelled = FALSE, charlson does not return variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE)
  cs <- charlson(x = x, id = "id", code = "code", labelled = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
})

test_that("if factorise = TRUE charlson returns factors", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE)
  cs <- charlson(x = x, id = "id", code = "code", factorise = TRUE)
  expect_s3_class(cs$ami, "factor")
  expect_s3_class(cs$chf, "factor")
  expect_s3_class(cs$pvd, "factor")
  expect_s3_class(cs$cevd, "factor")
  expect_s3_class(cs$dementia, "factor")
  expect_s3_class(cs$copd, "factor")
  expect_s3_class(cs$rheumd, "factor")
  expect_s3_class(cs$pud, "factor")
  expect_s3_class(cs$mld, "factor")
  expect_s3_class(cs$diab, "factor")
  expect_s3_class(cs$diabwc, "factor")
  expect_s3_class(cs$hp, "factor")
  expect_s3_class(cs$rend, "factor")
  expect_s3_class(cs$canc, "factor")
  expect_s3_class(cs$msld, "factor")
  expect_s3_class(cs$metacanc, "factor")
  expect_s3_class(cs$aids, "factor")
  expect_s3_class(cs$index, "factor")
})

test_that("if factorise = FALSE charlson does not return factors", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE)
  cs <- charlson(x = x, id = "id", code = "code", factorise = FALSE)
  expect_false("factor" %in% class(cs$ami))
  expect_false("factor" %in% class(cs$chf))
  expect_false("factor" %in% class(cs$pvd))
  expect_false("factor" %in% class(cs$cevd))
  expect_false("factor" %in% class(cs$dementia))
  expect_false("factor" %in% class(cs$copd))
  expect_false("factor" %in% class(cs$rheumd))
  expect_false("factor" %in% class(cs$pud))
  expect_false("factor" %in% class(cs$mld))
  expect_false("factor" %in% class(cs$diab))
  expect_false("factor" %in% class(cs$diabwc))
  expect_false("factor" %in% class(cs$hp))
  expect_false("factor" %in% class(cs$rend))
  expect_false("factor" %in% class(cs$canc))
  expect_false("factor" %in% class(cs$msld))
  expect_false("factor" %in% class(cs$metacanc))
  expect_false("factor" %in% class(cs$aids))
  expect_s3_class(cs$index, "factor")
})