context("ICD-9 codes for the Charlson score are properly identified")

test_that("Charlson code, ICD-9 codes", {
  this <- .maps[["charlson_icd9_quan"]]
  for (i in seq_along(this)) {
    cmb <- names(this)[i]
    for (j in seq_along(this[[i]])) {
      # For debugging: cat(this[[i]][j], "\n")
      x <- data.frame(id = 1, code = this[[i]][j])
      test <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
      expect_equal(object = test[[cmb]], expected = 1)
      if (x$code %in% c("40403", "40413", "40493", "4373")) {
        # These codes here overlap different domains
        expect_equal(object = sum(test[, -1]), expected = 2)
      } else {
        expect_equal(object = sum(test[, -1]), expected = 1)
      }
    }
  }
})
