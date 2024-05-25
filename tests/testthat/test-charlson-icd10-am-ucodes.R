context("ICD-10 codes for the Charlson score (Australian version) with U codes are properly identified")

test_that("Charlson code, ICD-10 codes, Australian version with U codes", {
  this <- .maps[["charlson_icd10_am_ucodes"]]
  for (i in seq_along(this)) {
    cmb <- names(this)[i]
    for (j in seq_along(this[[i]])) {
      # For debugging: cat(this[[i]][j], "\n")
      x <- data.frame(id = 1, code = this[[i]][j])
      test <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_am_ucodes", assign0 = FALSE)
      expect_equal(object = test[[cmb]], expected = 1)
      if (x$code %in% c("C80")) {
        # These codes here overlap different domains
        expect_equal(object = sum(test[, -1]), expected = 2)
      } else {
        expect_equal(object = sum(test[, -1]), expected = 1)
      }
    }
  }
})
