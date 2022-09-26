context("issue #55")

test_that("character id is supported", {
  n <- 5
  N <- 10
  x <- data.frame(
    id = rep(x = seq(n), each = N),
    code = sample_diag(N * n)
  )
  x$id <- as.character(x$id)
  cmb <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  testthat::expect_equal(object = nrow(cmb), expected = n)
  testthat::expect_s3_class(object = cmb, class = "data.frame")
})

test_that("character vs integer id makes no difference", {
  for (times in seq(50)) {
    n <- 5
    N <- 10
    x <- data.frame(
      id = rep(x = seq(n), each = N),
      code = sample_diag(N * n)
    )
    cmb1 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    x$id <- as.character(x$id)
    cmb2 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
    cmb1 <- cmb1[sort(cmb2$id), ]
    row.names(cmb1) <- NULL
    row.names(cmb2) <- NULL
    testthat::expect_equal(object = cmb1[, -which(names(cmb1) == "id")], expected = cmb2[, -which(names(cmb2) == "id")])
  }
})

test_that("character id with extra columns", {
  n <- 5
  N <- 10
  x <- data.frame(
    id = rep(x = seq(n), each = N),
    code = sample_diag(N * n)
  )
  x$id <- as.character(x$id)
  cmb <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
  testthat::expect_equal(object = nrow(cmb), expected = n)
  testthat::expect_s3_class(object = cmb, class = "data.frame")
})
