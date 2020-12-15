context("issue #32")

test_that("New parameters of 'assign0' are recognised correctly", {
  x <- data.frame(
    id = 1,
    code = c("B18", "E100", "E102", "C01", "I850", "C77")
  )
  xnone <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "none")
  xscore <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "score")
  xboth <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "both")
  expect_s3_class(object = xnone, class = "data.frame")
  expect_s3_class(object = xscore, class = "data.frame")
  expect_s3_class(object = xboth, class = "data.frame")
})

test_that("Results are different depending on values of 'assign0'", {
  x <- data.frame(
    id = 1,
    code = c("B18", "E100", "E102", "C01", "I850", "C77", "I10", "I11", "E100", "E102", "C80", "C30")
  )
  # Charlson score
  xnone <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "none")
  xscore <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "score")
  xboth <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "both")
  expect_false(all(xnone == xscore))
  expect_false(all(xnone == xboth))
  expect_false(all(xscore == xboth))
  # Elixhauser
  xnone <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = "none")
  xscore <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = "score")
  xboth <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = "both")
  expect_false(all(xnone == xscore))
  expect_false(all(xnone == xboth))
  expect_false(all(xscore == xboth))
})
