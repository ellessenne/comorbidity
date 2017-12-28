context("comorbidity")

test_that("comorbidity returns an error if x is a vector", {
  x <- sample_diag_icd10(50)
  expect_error(
    comorbidity(x = x, id = "id", code = "code")
  )
})

test_that("comorbidity returns an error if x, id, code, score are not provided", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag_icd10(50),
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
    comorbidity(score = "charlson_icd10")
  )
  expect_error(
    comorbidity(x = x, id = "id")
  )
  expect_error(
    comorbidity(x = x, code = "code")
  )
  expect_error(
    comorbidity(x = x, score = "charlson_icd10")
  )
  expect_error(
    comorbidity(id = "id", code = "code")
  )
  expect_error(
    comorbidity(id = "id", score = "charlson_icd10")
  )
  expect_error(
    comorbidity(code = "code", score = "charlson_icd10")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code")
  )
  expect_error(
    comorbidity(x = x, code = "code", score = "charlson_icd10")
  )
  expect_error(
    comorbidity(x = x, id = "id", score = "charlson_icd10")
  )
  expect_error(
    comorbidity(id = "id", code = "code", score = "charlson_icd10")
  )
})

test_that("comorbidity returns an error if id, code not in x", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag_icd10(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    comorbidity(x = x, id = "ID", code = "code", score = "charlson_icd10")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "CODE", score = "charlson_icd10")
  )
  expect_error(
    comorbidity(x = x, id = "ID", code = "CODE", score = "charlson_icd10")
  )
})

test_that("charlson checks for its arguments properly", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag_icd10(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", assign0 = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", assign0 = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", factorise = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", factorise = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", labelled = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", labelled = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", tidy.codes = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", tidy.codes = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", mc.cores = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", mc.cores = TRUE)
  )
})

test_that("comorbidity messages when tidy.codes is set to FALSE", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag_icd10(50),
    stringsAsFactors = FALSE
  )
  expect_message(
    comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", tidy.codes = FALSE)
  )
})

test_that("comorbidity returns a data.frame", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag_icd10(50),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10")
  expect_s3_class(cs, "data.frame")
})

test_that("comorbidity returns a data.frame with the correct number of rows", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag_icd10(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")
  expect_equal(nrow(cs), 5)
  x <- data.frame(
    id = sample(1:50, size = 10 * 50, replace = TRUE),
    code = sample_diag_icd10(10 * 50),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")
  expect_equal(nrow(cs), 50)
})

test_that("if labelled = TRUE, comorbidity returns variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag_icd10(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", labelled = TRUE)
  expect_false(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", labelled = TRUE)
  expect_false(is.null(attr(cs, "variable.labels")))
})

test_that("if labelled = FALSE, comorbidity does not return variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag_icd10(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", labelled = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", labelled = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
})

test_that("if factorise = TRUE comorbidity returns factors", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag_icd10(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", factorise = TRUE)
  expect_s3_class(cs$ami, "factor")
  expect_s3_class(cs$chf, "factor")
  expect_s3_class(cs$pvd, "factor")
  expect_s3_class(cs$cevd, "factor")
  expect_s3_class(cs$dementia, "factor")
  expect_s3_class(cs$copd, "factor")
  expect_s3_class(cs$rheumd, "factor")
  expect_s3_class(cs$pud, "factor")
  expect_s3_class(cs$mld, "factor")
  expect_s3_class(cs$diab, "factor")
  expect_s3_class(cs$diabwc, "factor")
  expect_s3_class(cs$hp, "factor")
  expect_s3_class(cs$rend, "factor")
  expect_s3_class(cs$canc, "factor")
  expect_s3_class(cs$msld, "factor")
  expect_s3_class(cs$metacanc, "factor")
  expect_s3_class(cs$aids, "factor")
  expect_s3_class(cs$index, "factor")
  expect_s3_class(cs$windex, "factor")
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", factorise = TRUE)
  expect_s3_class(cs$chf, "factor")
  expect_s3_class(cs$carit, "factor")
  expect_s3_class(cs$valv, "factor")
  expect_s3_class(cs$pcd, "factor")
  expect_s3_class(cs$pvd, "factor")
  expect_s3_class(cs$hypunc, "factor")
  expect_s3_class(cs$hypc, "factor")
  expect_s3_class(cs$para, "factor")
  expect_s3_class(cs$ond, "factor")
  expect_s3_class(cs$cpd, "factor")
  expect_s3_class(cs$diabunc, "factor")
  expect_s3_class(cs$diabc, "factor")
  expect_s3_class(cs$hypothy, "factor")
  expect_s3_class(cs$rf, "factor")
  expect_s3_class(cs$ld, "factor")
  expect_s3_class(cs$pud, "factor")
  expect_s3_class(cs$aids, "factor")
  expect_s3_class(cs$lymph, "factor")
  expect_s3_class(cs$metacanc, "factor")
  expect_s3_class(cs$solidtum, "factor")
  expect_s3_class(cs$rheumd, "factor")
  expect_s3_class(cs$coag, "factor")
  expect_s3_class(cs$obes, "factor")
  expect_s3_class(cs$wloss, "factor")
  expect_s3_class(cs$fed, "factor")
  expect_s3_class(cs$blane, "factor")
  expect_s3_class(cs$dane, "factor")
  expect_s3_class(cs$alcohol, "factor")
  expect_s3_class(cs$drug, "factor")
  expect_s3_class(cs$psycho, "factor")
  expect_s3_class(cs$depre, "factor")
  expect_s3_class(cs$index, "factor")
  expect_s3_class(cs$windex, "factor")
})

test_that("if factorise = FALSE comorbidity does not return factors", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag_icd10(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", score = "charlson_icd10", code = "code", factorise = FALSE)
  expect_false("factor" %in% class(cs$ami))
  expect_false("factor" %in% class(cs$chf))
  expect_false("factor" %in% class(cs$pvd))
  expect_false("factor" %in% class(cs$cevd))
  expect_false("factor" %in% class(cs$dementia))
  expect_false("factor" %in% class(cs$copd))
  expect_false("factor" %in% class(cs$rheumd))
  expect_false("factor" %in% class(cs$pud))
  expect_false("factor" %in% class(cs$mld))
  expect_false("factor" %in% class(cs$diab))
  expect_false("factor" %in% class(cs$diabwc))
  expect_false("factor" %in% class(cs$hp))
  expect_false("factor" %in% class(cs$rend))
  expect_false("factor" %in% class(cs$canc))
  expect_false("factor" %in% class(cs$msld))
  expect_false("factor" %in% class(cs$metacanc))
  expect_false("factor" %in% class(cs$aids))
  expect_s3_class(cs$index, "factor")
  expect_s3_class(cs$windex, "factor")
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", factorise = FALSE)
  expect_false("factor" %in% class(cs$chf))
  expect_false("factor" %in% class(cs$carit))
  expect_false("factor" %in% class(cs$valv))
  expect_false("factor" %in% class(cs$pcd))
  expect_false("factor" %in% class(cs$pvd))
  expect_false("factor" %in% class(cs$hypunc))
  expect_false("factor" %in% class(cs$hypc))
  expect_false("factor" %in% class(cs$para))
  expect_false("factor" %in% class(cs$ond))
  expect_false("factor" %in% class(cs$cpd))
  expect_false("factor" %in% class(cs$diabunc))
  expect_false("factor" %in% class(cs$diabc))
  expect_false("factor" %in% class(cs$hypothy))
  expect_false("factor" %in% class(cs$rf))
  expect_false("factor" %in% class(cs$ld))
  expect_false("factor" %in% class(cs$pud))
  expect_false("factor" %in% class(cs$aids))
  expect_false("factor" %in% class(cs$lymph))
  expect_false("factor" %in% class(cs$metacanc))
  expect_false("factor" %in% class(cs$solidtum))
  expect_false("factor" %in% class(cs$rheumd))
  expect_false("factor" %in% class(cs$coag))
  expect_false("factor" %in% class(cs$obes))
  expect_false("factor" %in% class(cs$wloss))
  expect_false("factor" %in% class(cs$fed))
  expect_false("factor" %in% class(cs$blane))
  expect_false("factor" %in% class(cs$dane))
  expect_false("factor" %in% class(cs$alcohol))
  expect_false("factor" %in% class(cs$drug))
  expect_false("factor" %in% class(cs$psycho))
  expect_false("factor" %in% class(cs$depre))
  expect_s3_class(cs$index, "factor")
  expect_s3_class(cs$windex, "factor")
})

test_that("parallel computing works (specifying the number of clusters)", {
  x <- data.frame(
    id = sample(1:50, size = 10 * 50, replace = TRUE),
    code = sample_diag_icd10(10 * 50),
    stringsAsFactors = FALSE
  )
  cs1 <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = TRUE, mc.cores = 1)
  cs2 <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = TRUE, mc.cores = 2)
  cs3 <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", parallel = TRUE, mc.cores = 1)
  cs4 <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", parallel = TRUE, mc.cores = 2)
  expect_equal(nrow(cs1), 50)
  expect_equal(nrow(cs2), 50)
  expect_equal(nrow(cs3), 50)
  expect_equal(nrow(cs4), 50)
})

test_that("running computations in parallel vs serial returns the same results", {
  x <- data.frame(
    id = sample(1:50, size = 10 * 50, replace = TRUE),
    code = sample_diag_icd10(10 * 50),
    stringsAsFactors = FALSE
  )
  cs_serial <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = FALSE)
  cs_parallel <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = TRUE, mc.cores = 2)
  expect_equal(cs_serial, cs_parallel)
  cs_serial <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", parallel = FALSE)
  cs_parallel <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10", parallel = TRUE, mc.cores = 2)
  expect_equal(cs_serial, cs_parallel)
})
