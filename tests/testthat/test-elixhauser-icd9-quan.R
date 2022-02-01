context("ICD-9 codes for the Elixhauser score are properly identified")

test_that("Elixhauser code, ICD-9 codes", {
  this <- .maps[["elixhauser_icd9_quan"]]
  for (i in seq_along(this)) {
    cmb <- names(this)[i]
    for (j in seq_along(this[[i]])) {
      # For debugging: cat(this[[i]][j], "\n")
      x <- data.frame(id = 1, code = this[[i]][j])
      test <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
      if (x$code %in% c("40201", "40211", "40291", "40401", "40411", "40491", "4255", "5710", "5711", "5712", "5713", "3341", "4168", "4169", "40301", "40311", "40391", "40402", "40412", "40492", "29654")) {
        # These codes here overlap two domains
        expect_equal(object = sum(test[, -1]), expected = 2)
      } else if (x$code %in% c("40403", "40413", "40493")) {
        # These codes here overlap three domains
        expect_equal(object = sum(test[, -1]), expected = 3)
      } else {
        expect_equal(object = sum(test[, -1]), expected = 1)
      }
    }
  }
})
