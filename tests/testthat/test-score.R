context("score")

test_that("score errors out if called on non-comorbidity object", {
  x <- sample_diag(50)
  expect_error(score(x = x, assign0 = FALSE))
  expect_error(score(x = x, assign0 = TRUE))
})
