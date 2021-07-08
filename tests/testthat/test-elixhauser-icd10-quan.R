context("ICD-10 codes for the Elixhauser score are properly identified")

test_that("Elixhauser code, ICD-10 codes", {
  this <- .maps[["elixhauser_icd10_quan"]]
  for (i in seq_along(this)) {
    cmb <- names(this)[i]
    for (j in seq_along(this[[i]])) {
      # For debugging: cat(this[[i]][j], "\n")
      x <- data.frame(id = 1, code = this[[i]][j])
      test <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
      if (x$code %in% c("I110", "I130", "I132", "I426", "G114", "I278", "I279", "I120", "I131", "K700", "K703", "K709", "F315", "F204")) {
        # These codes here overlap two domains
        expect_equal(object = sum(test[, -1]), expected = 2)
      } else {
        expect_equal(object = sum(test[, -1]), expected = 1)
      }
    }
  }
})
