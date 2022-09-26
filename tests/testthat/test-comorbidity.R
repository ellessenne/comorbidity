context("comorbidity")

test_that("comorbidity returns an error if x is a vector", {
  x <- sample_diag(50)
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan")
  )
})

test_that("comorbidity returns an error if x, id, code, score are not provided", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    comorbidity(x = x)
  )
  expect_error(
    comorbidity(id = "id")
  )
  expect_error(
    comorbidity(code = "code")
  )
  expect_error(
    comorbidity(map = "charlson_icd10_quan")
  )
  expect_error(
    comorbidity(x = x, id = "id")
  )
  expect_error(
    comorbidity(x = x, code = "code")
  )
  expect_error(
    comorbidity(x = x, map = "charlson_icd10_quan")
  )
  expect_error(
    comorbidity(id = "id", code = "code")
  )
  expect_error(
    comorbidity(id = "id", map = "charlson_icd10_quan")
  )
  expect_error(
    comorbidity(code = "code", map = "charlson_icd10_quan")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code")
  )
  expect_error(
    comorbidity(x = x, code = "code", map = "charlson_icd10_quan")
  )
  expect_error(
    comorbidity(x = x, id = "id", map = "charlson_icd10_quan")
  )
  expect_error(
    comorbidity(id = "id", code = "code", map = "charlson_icd10_quan")
  )
})

test_that("comorbidity returns an error if id, code not in x", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    comorbidity(x = x, id = "ID", code = "code", map = "charlson_icd10_quan", assign0 = TRUE)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "CODE", map = "charlson_icd10_quan", assign0 = TRUE)
  )
  expect_error(
    comorbidity(x = x, id = "ID", code = "CODE", map = "charlson_icd10_quan", assign0 = TRUE)
  )
})

test_that("charlson checks for its arguments properly", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    suppressWarnings(comorbidity(x = x, id = 123, code = "code", map = "charlson_icd10_quan", assign0 = TRUE))
  )
  expect_error(
    suppressWarnings(comorbidity(x = x, id = TRUE, code = "code", map = "charlson_icd10_quan", assign0 = TRUE))
  )
  expect_error(
    suppressWarnings(comorbidity(x = x, id = "id", code = 123, map = "charlson_icd10_quan", assign0 = TRUE))
  )
  expect_error(
    suppressWarnings(comorbidity(x = x, id = "id", code = TRUE, map = "charlson_icd10_quan", assign0 = TRUE))
  )
  expect_error(
    suppressWarnings(comorbidity(x = x, id = "id", code = "code", map = 123, assign0 = TRUE))
  )
  expect_error(
    suppressWarnings(comorbidity(x = x, id = "id", code = "code", map = TRUE, assign0 = TRUE))
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = "TRUE")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", labelled = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", labelled = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", tidy.codes = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", tidy.codes = "1")
  )
})

test_that("comorbidity returns a data.frame", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  x9 <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x9, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x9, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
})

test_that("comorbidity returns a data.frame with the correct number of rows", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  expect_equal(nrow(cs), 5)
  x <- data.frame(
    id = sample(1:50, size = 10 * 50, replace = TRUE),
    code = sample_diag(10 * 50, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
  expect_equal(nrow(cs), 50)
})

test_that("if labelled = TRUE, comorbidity returns variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", labelled = TRUE, assign0 = FALSE)
  expect_false(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", labelled = TRUE, assign0 = FALSE)
  expect_false(is.null(attr(cs, "variable.labels")))
})

test_that("if labelled = FALSE, comorbidity does not return variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  x9 <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x9, id = "id", code = "code", map = "charlson_icd9_quan", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x9, id = "id", code = "code", map = "elixhauser_icd9_quan", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
})

test_that("comorbidity domains are 0 or 1", {
  dat <- expand.grid(
    record_id = 8,
    diagnosis_icd_2 = c("G92", "J984, M419", "A0472", "A419", "D696", "E11621", "E119", "E669", "E875", "G40909", "G8220", "G904", "I10", "I248", "I2720", "I5030", "I5033", "I82411", "I824Y1", "J45909", "J9621", "K5900", "K592", "L89310", "L89620", "L89890", "L97529", "M21372", "M419", "N179", "N319", "N390", "Q056", "Q058", "R440", "R578", "T426X5A", "T428X5A", "T83510A", "Z6835", "Z713", "Z781", "Z7982", "Z853", "Z981")
  )
  elixhauser10 <- comorbidity(x = dat, id = "record_id", code = "diagnosis_icd_2", map = "elixhauser_icd10_quan", assign0 = TRUE, labelled = FALSE, tidy.codes = FALSE)[, -1]
  expect_true(object = all(elixhauser10 >= 0 & elixhauser10 <= 1))

  for (i in seq(10)) {
    x <- data.frame(
      id = sample(1:5, size = 50, replace = TRUE),
      code = sample_diag(50),
      stringsAsFactors = FALSE
    )
    elixhauser10 <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)[, -1]
    expect_true(object = all(elixhauser10 >= 0 & elixhauser10 <= 1))
    charlson10 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)[, -1]
    expect_true(object = all(charlson10 >= 0 & charlson10 <= 1))
    x <- data.frame(
      id = sample(1:5, size = 50, replace = TRUE),
      code = sample_diag(50, version = "ICD9_2015"),
      stringsAsFactors = FALSE
    )
    elixhauser9 <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)[, -1]
    expect_true(object = all(elixhauser9 >= 0 & elixhauser9 <= 1))
    charlson9 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)[, -1]
    expect_true(object = all(charlson9 >= 0 & charlson9 <= 1))
  }
})

test_that("duplicate codes are not counted twice (or more)", {
  for (i in seq(10)) {
    x <- data.frame(
      id = sample(1:20, size = 50, replace = TRUE),
      code = sample_diag(50),
      stringsAsFactors = FALSE
    )
    x2 <- rbind(x, x)
    x3 <- rbind(x, x, x)
    x4 <- rbind(x, x, x, x)
    cx <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    cx2 <- comorbidity(x = x2, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    cx3 <- comorbidity(x = x3, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    cx4 <- comorbidity(x = x4, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    ex <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
    ex2 <- comorbidity(x = x2, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
    ex3 <- comorbidity(x = x3, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
    ex4 <- comorbidity(x = x4, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
    expect_equal(object = cx, expected = cx2)
    expect_equal(object = cx, expected = cx3)
    expect_equal(object = cx, expected = cx4)
    expect_equal(object = cx2, expected = cx3)
    expect_equal(object = cx2, expected = cx4)
    expect_equal(object = cx3, expected = cx4)
    expect_true(object = all(cx[, -1] >= 0 & cx[, -1] <= 1))
    expect_true(object = all(cx2[, -1] >= 0 & cx2[, -1] <= 1))
    expect_true(object = all(cx3[, -1] >= 0 & cx3[, -1] <= 1))
    expect_true(object = all(cx4[, -1] >= 0 & cx4[, -1] <= 1))
    expect_equal(object = ex, expected = ex2)
    expect_equal(object = ex, expected = ex3)
    expect_equal(object = ex, expected = ex4)
    expect_equal(object = ex2, expected = ex3)
    expect_equal(object = ex2, expected = ex4)
    expect_equal(object = ex3, expected = ex4)
    expect_true(object = all(ex[, -1] >= 0 & ex[, -1] <= 1))
    expect_true(object = all(ex2[, -1] >= 0 & ex2[, -1] <= 1))
    expect_true(object = all(ex3[, -1] >= 0 & ex3[, -1] <= 1))
    expect_true(object = all(ex4[, -1] >= 0 & ex4[, -1] <= 1))
  }

  for (i in seq(10)) {
    x <- data.frame(
      id = sample(1:20, size = 50, replace = TRUE),
      code = sample_diag(50),
      version = "ICD9_2015",
      stringsAsFactors = FALSE
    )
    x2 <- rbind(x, x)
    x3 <- rbind(x, x, x)
    x4 <- rbind(x, x, x, x)
    cx <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
    cx2 <- comorbidity(x = x2, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
    cx3 <- comorbidity(x = x3, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
    cx4 <- comorbidity(x = x4, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
    ex <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
    ex2 <- comorbidity(x = x2, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
    ex3 <- comorbidity(x = x3, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
    ex4 <- comorbidity(x = x4, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
    expect_equal(object = cx, expected = cx2)
    expect_equal(object = cx, expected = cx3)
    expect_equal(object = cx, expected = cx4)
    expect_equal(object = cx2, expected = cx3)
    expect_equal(object = cx2, expected = cx4)
    expect_equal(object = cx3, expected = cx4)
    expect_true(object = all(cx[2:18] >= 0 & cx[2:18] <= 1))
    expect_true(object = all(cx2[2:18] >= 0 & cx2[2:18] <= 1))
    expect_true(object = all(cx3[2:18] >= 0 & cx3[2:18] <= 1))
    expect_true(object = all(cx4[2:18] >= 0 & cx4[2:18] <= 1))
    expect_equal(object = ex, expected = ex2)
    expect_equal(object = ex, expected = ex3)
    expect_equal(object = ex, expected = ex4)
    expect_equal(object = ex2, expected = ex3)
    expect_equal(object = ex2, expected = ex4)
    expect_equal(object = ex3, expected = ex4)
    expect_true(object = all(ex[2:32] >= 0 & ex[2:32] <= 1))
    expect_true(object = all(ex2[2:32] >= 0 & ex2[2:32] <= 1))
    expect_true(object = all(ex3[2:32] >= 0 & ex3[2:32] <= 1))
    expect_true(object = all(ex4[2:32] >= 0 & ex4[2:32] <= 1))
  }
})

test_that("input dataset with additional columns", {
  x <- data.frame(
    id = sample(1:20, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  x2 <- x
  x2$noise <- rnorm(n = nrow(x2))
  c <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  c2 <- comorbidity(x = x2, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  expect_equal(object = c2, expected = c)
  e <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
  e2 <- comorbidity(x = x2, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
  expect_equal(object = e2, expected = e)

  x <- data.frame(
    id = sample(1:20, size = 50, replace = TRUE),
    code = sample_diag(50),
    version = "ICD9_2015",
    stringsAsFactors = FALSE
  )
  x2 <- x
  x2$noise <- rnorm(n = nrow(x2))
  c <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
  c2 <- comorbidity(x = x2, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
  expect_equal(object = c2, expected = c)
  e <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
  e2 <- comorbidity(x = x2, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
  expect_equal(object = e2, expected = e)
})

test_that("all comorbidities", {
  data("icd10_2011", package = "comorbidity")
  icd10_2011$id <- 1
  c <- comorbidity(x = icd10_2011, id = "id", code = "Code", map = "charlson_icd10_quan", assign0 = FALSE)
  e <- comorbidity(x = icd10_2011, id = "id", code = "Code", map = "elixhauser_icd10_quan", assign0 = FALSE)
  expect_true(object = all(c[, -1] == 1))
  expect_true(object = all(e[, -1] == 1))
  data("icd10_2009", package = "comorbidity")
  icd10_2009$id <- 1
  c <- comorbidity(x = icd10_2009, id = "id", code = "Code", map = "charlson_icd10_quan", assign0 = FALSE)
  e <- comorbidity(x = icd10_2009, id = "id", code = "Code", map = "elixhauser_icd10_quan", assign0 = FALSE)
  expect_true(object = all(c[, -1] == 1))
  expect_true(object = all(e[, -1] == 1))
  data("icd9_2015", package = "comorbidity")
  icd9_2015$id <- 1
  c <- comorbidity(x = icd9_2015, id = "id", code = "Code", map = "charlson_icd9_quan", assign0 = FALSE)
  e <- comorbidity(x = icd9_2015, id = "id", code = "Code", map = "elixhauser_icd9_quan", assign0 = FALSE)
  expect_true(object = all(c[, -1] == 1))
  expect_true(object = all(e[, -1] == 1))
})

test_that("break output checks", {
  x <- data.frame(
    id = sample(1:20, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  cx <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  cx[, -1] <- cx[, -1] + rnorm(n = nrow(cx))
  expect_error(.check_output(x = cx, id = "id"), regexp = "unexpected state")
  ex <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
  ex[, -1] <- ex[, -1] + rnorm(n = nrow(ex))
  expect_error(.check_output(x = ex, id = "id"), regexp = "unexpected state")
})

test_that("works ok with data.table", {
  library(data.table)
  x <- data.frame(
    id = sample(1:20, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  c <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  c.dt <- comorbidity(x = data.table::setDT(x), id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  expect_equal(object = c.dt, expected = c)
  x <- data.frame(
    id = sample(1:20, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  x$noise <- stats::rnorm(n = nrow(x))
  c <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  c.dt <- comorbidity(x = data.table::setDT(x), id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  expect_equal(object = c.dt, expected = c)
})
