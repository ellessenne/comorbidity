context("ICD-10-AM codes for the M3 score are properly identified")

test_that("M3, ICD-10 codes", {
  
  this <- .maps[["m3_icd10_am"]]
  for (i in seq_along(this)) {
    cmb <- names(this)[i]
    for (j in seq_along(this[[i]])) {
      # For debugging: cat(this[[i]][j], "\n")
      x <- data.frame(id = 1, code = this[[i]][j])
      test <- comorbidity(x = x, id = "id", code = "code", map = "m3_icd10_am", assign0 = FALSE)
      
      if (x$code %in% c("I20", "I20", "I20", "I21", "I21", "I21", "I22", "I22", "I22", 
                        "I23", "I23", "I23", "I241", "I248", "I249", "I250", "I251", 
                        "I252", "I253", "I254", "I255", "I256", "I258", "I259", "I60", 
                        "I61", "I62", "I63", "I64", "I65", "I66", "I67", "I69", "I70", 
                        "I70", "I71", "I71", "I72", "I72", "N032", "N033", "N034", "N035", 
                        "N036", "N037", "N038", "N039", "N042", "N043", "N044", "N045", 
                        "N046", "N047", "N048", "N049", "N18", "N18", "N18")) {
        # These codes here overlap three different domains
        expect_equal(object = sum(test[, -1]), expected = 3)
      } else if (x$code %in% c("G603", "G620", "G621", "G622", "G628", "G629", "H35", "H35", 
                               "I110", "I119", "I120", "I129", "I130", "I131", "I132", "I139", 
                               "I24", "I24", "I25", "I25", "I6", "I6", "I731", "I738", "I739", 
                               "I74", "I771", "M80", "M80", "N03", "N03", "N04", "N04")) {
        # These codes here overlap two different domains
        expect_equal(object = sum(test[, -1]), expected = 2)
      } else {
        expect_equal(object = sum(test[, -1]), expected = 1)
      }
      
    }
  }
})
