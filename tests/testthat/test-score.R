context("score")

test_that("score errors out if called on non-comorbidity object", {
  x <- sample_diag(50)
  expect_error(score(x = x, assign0 = FALSE))
  expect_error(score(x = x, assign0 = TRUE))
})

test_that("Argument checks work fine", {
  # ICD10
  set.seed(1)
  x <- data.frame(
    id = sample(1:15, size = 200, replace = TRUE),
    code = sample_diag(200)
  )
  xc <- lapply(
    X = grep(pattern = "icd10", x = names(.maps), value = TRUE),
    FUN = function(w) comorbidity(x = x, id = "id", code = "code", map = w, assign0 = FALSE)
  )
  for (i in seq_along(xc)) {
    # Need some attributes
    expect_error(score(x = xc[[i]]))
    # 'assign0' must be a boolean
    expect_error(score(x = xc[[i]], assign0 = 1))
    expect_error(score(x = xc[[i]], assign0 = "yes"))
    expect_error(score(x = xc[[i]], assign0 = NA))
    # 'weights' must be one of the correct ones...
    for (w in names(.weights[[attr(xc[[i]], "map")]])) {
      expect_error(score(x = xc[[i]], weights = paste0(w, "_", sample(x = LETTERS, size = 1)), assign0 = TRUE))
      expect_error(score(x = xc[[i]], weights = paste0(w, "_", sample(x = LETTERS, size = 1)), assign0 = FALSE))
      expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = TRUE)), expected = length(unique(x$id)))
      expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = FALSE)), expected = length(unique(x$id)))
    }
  }
  # ICD9
  set.seed(1)
  x <- data.frame(
    id = sample(1:15, size = 200, replace = TRUE),
    code = sample_diag(200, version = "ICD9_2015")
  )
  xc <- lapply(
    X = grep(pattern = "icd9", x = names(.maps), value = TRUE),
    FUN = function(w) comorbidity(x = x, id = "id", code = "code", map = w, assign0 = FALSE)
  )
  for (i in seq_along(xc)) {
    # Need some attributes
    expect_error(score(x = xc[[i]]))
    # 'assign0' must be a boolean
    expect_error(score(x = xc[[i]], assign0 = 1))
    expect_error(score(x = xc[[i]], assign0 = "yes"))
    expect_error(score(x = xc[[i]], assign0 = NA))
    # 'weights' must be one of the correct ones...
    for (w in names(.weights[[attr(xc[[i]], "map")]])) {
      expect_error(score(x = xc[[i]], weights = paste0(w, "_", sample(x = LETTERS, size = 1)), assign0 = TRUE))
      expect_error(score(x = xc[[i]], weights = paste0(w, "_", sample(x = LETTERS, size = 1)), assign0 = FALSE))
      expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = TRUE)), expected = length(unique(x$id)))
      expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = FALSE)), expected = length(unique(x$id)))
    }
  }
})


test_that("Length of output is correct", {
  for (n in seq(10)) {
    x <- data.frame(
      id = sample(sample(x = seq(100), size = 1), size = 200, replace = TRUE),
      code10 = sample_diag(200, version = "ICD10_2011"),
      code9 = sample_diag(200, version = "ICD9_2015")
    )
    # ICD10
    xc <- lapply(
      X = grep(pattern = "icd10", x = names(.maps), value = TRUE),
      FUN = function(w) comorbidity(x = x, id = "id", code = "code10", map = w, assign0 = FALSE)
    )
    for (i in seq_along(xc)) {
      for (w in names(.weights[[attr(xc[[i]], "map")]])) {
        expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = TRUE)), expected = length(unique(x$id)))
        expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = FALSE)), expected = length(unique(x$id)))
      }
    }
    # ICD9
    xc <- lapply(
      X = grep(pattern = "icd9", x = names(.maps), value = TRUE),
      FUN = function(w) comorbidity(x = x, id = "id", code = "code9", map = w, assign0 = FALSE)
    )
    for (i in seq_along(xc)) {
      for (w in names(.weights[[attr(xc[[i]], "map")]])) {
        expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = TRUE)), expected = length(unique(x$id)))
        expect_equal(object = length(score(x = xc[[i]], weights = w, assign0 = FALSE)), expected = length(unique(x$id)))
      }
    }
  }
})
