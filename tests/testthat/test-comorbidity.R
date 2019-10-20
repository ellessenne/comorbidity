context("comorbidity")

test_that("comorbidity returns an error if x is a vector", {
  x <- sample_diag(50)
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson")
  )
})

test_that("comorbidity returns an error if x, id, code, score are not provided", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
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
    comorbidity(score = "charlson")
  )
  expect_error(
    comorbidity(x = x, id = "id")
  )
  expect_error(
    comorbidity(x = x, code = "code")
  )
  expect_error(
    comorbidity(x = x, score = "charlson")
  )
  expect_error(
    comorbidity(id = "id", code = "code")
  )
  expect_error(
    comorbidity(id = "id", score = "charlson")
  )
  expect_error(
    comorbidity(code = "code", score = "charlson")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code")
  )
  expect_error(
    comorbidity(x = x, code = "code", score = "charlson")
  )
  expect_error(
    comorbidity(x = x, id = "id", score = "charlson")
  )
  expect_error(
    comorbidity(id = "id", code = "code", score = "charlson")
  )
})

test_that("comorbidity returns an error if id, code not in x", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    comorbidity(x = x, id = "ID", code = "code", score = "charlson")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "CODE", score = "charlson")
  )
  expect_error(
    comorbidity(x = x, id = "ID", code = "CODE", score = "charlson")
  )
})

test_that("charlson checks for its arguments properly", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", factorise = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", factorise = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", labelled = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", labelled = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", tidy.codes = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", tidy.codes = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", parallel = 1)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", parallel = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", mc.cores = "1")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", mc.cores = TRUE)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd11")
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = 9)
  )
  expect_error(
    comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = 10)
  )
})

test_that("comorbidity returns a data.frame", {
  x <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50),
    stringsAsFactors = FALSE
  )
  x9 <- data.frame(
    id = sample(1:5, size = 50, replace = TRUE),
    code = sample_diag(50, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x9, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
  cs <- comorbidity(x = x9, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
  expect_s3_class(cs, "data.frame")
})

test_that("comorbidity returns a data.frame with the correct number of rows", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(nrow(cs), 5)
  x <- data.frame(
    id = sample(1:50, size = 10 * 50, replace = TRUE),
    code = sample_diag(10 * 50, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(nrow(cs), 50)
})

test_that("if labelled = TRUE, comorbidity returns variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", labelled = TRUE, assign0 = FALSE)
  expect_false(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", labelled = TRUE, assign0 = FALSE)
  expect_false(is.null(attr(cs, "variable.labels")))
})

test_that("if labelled = FALSE, comorbidity does not return variable labels", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  x9 <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x9, id = "id", code = "code", score = "charlson", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
  cs <- comorbidity(x = x9, id = "id", code = "code", score = "elixhauser", labelled = FALSE, assign0 = FALSE)
  expect_true(is.null(attr(cs, "variable.labels")))
})

test_that("if factorise = TRUE comorbidity returns factors", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", factorise = TRUE, assign0 = FALSE)
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
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", factorise = TRUE, assign0 = FALSE)
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
  expect_s3_class(cs$windex_ahrq, "factor")
  expect_s3_class(cs$windex_vw, "factor")
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", code = "code", score = "charlson", factorise = TRUE, assign0 = FALSE)
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
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", factorise = TRUE, assign0 = FALSE)
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
  expect_s3_class(cs$windex_ahrq, "factor")
  expect_s3_class(cs$windex_vw, "factor")
})

test_that("if factorise = FALSE comorbidity does not return factors", {
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", score = "charlson", code = "code", factorise = FALSE, assign0 = FALSE)
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
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", factorise = FALSE, assign0 = FALSE)
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
  expect_s3_class(cs$windex_ahrq, "factor")
  expect_s3_class(cs$windex_vw, "factor")
  x <- data.frame(
    id = sample(1:5, size = 10 * 5, replace = TRUE),
    code = sample_diag(10 * 5, version = "ICD9_2015"),
    stringsAsFactors = FALSE
  )
  cs <- comorbidity(x = x, id = "id", score = "charlson", code = "code", factorise = FALSE, assign0 = FALSE)
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
  cs <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", factorise = FALSE, assign0 = FALSE)
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
  expect_s3_class(cs$windex_ahrq, "factor")
  expect_s3_class(cs$windex_vw, "factor")
})

test_that("comorbidity scores are 0 or 1", {
  dat <- expand.grid(
    record_id = 8,
    diagnosis_icd_2 = c("G92", "J984, M419", "A0472", "A419", "D696", "E11621", "E119", "E669", "E875", "G40909", "G8220", "G904", "I10", "I248", "I2720", "I5030", "I5033", "I82411", "I824Y1", "J45909", "J9621", "K5900", "K592", "L89310", "L89620", "L89890", "L97529", "M21372", "M419", "N179", "N319", "N390", "Q056", "Q058", "R440", "R578", "T426X5A", "T428X5A", "T83510A", "Z6835", "Z713", "Z781", "Z7982", "Z853", "Z981")
  )
  elixhauser10 <- comorbidity(x = dat, id = "record_id", code = "diagnosis_icd_2", score = "elixhauser", icd = "icd10", assign0 = T, factorise = F, labelled = F, tidy.codes = F)[, 2:32]
  expect_true(object = all(elixhauser10 >= 0 & elixhauser10 <= 1))

  for (i in seq(100)) {
    x <- data.frame(
      id = sample(1:5, size = 50, replace = TRUE),
      code = sample_diag(50),
      stringsAsFactors = FALSE
    )
    elixhauser10 <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", icd = "icd10", assign0 = FALSE)[, 2:32]
    expect_true(object = all(elixhauser10 >= 0 & elixhauser10 <= 1))
    charlson10 <- comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd10", assign0 = FALSE)[, 2:18]
    expect_true(object = all(charlson10 >= 0 & charlson10 <= 1))
    x <- data.frame(
      id = sample(1:5, size = 50, replace = TRUE),
      code = sample_diag(50, version = "ICD9_2015"),
      stringsAsFactors = FALSE
    )
    elixhauser9 <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", icd = "icd9", assign0 = FALSE)[, 2:32]
    expect_true(object = all(elixhauser9 >= 0 & elixhauser9 <= 1))
    charlson9 <- comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd9", assign0 = FALSE)[, 2:18]
    expect_true(object = all(charlson9 >= 0 & charlson9 <= 1))
  }
})

test_that("duplicate codes are not counted twice (or more)", {
  for (i in seq(100)) {
    x <- data.frame(
      id = sample(1:20, size = 300, replace = TRUE),
      code = sample_diag(300),
      stringsAsFactors = FALSE
    )
    x2 <- rbind(x, x)
    x3 <- rbind(x, x, x)
    x4 <- rbind(x, x, x, x)
    cx <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
    cx2 <- comorbidity(x = x2, id = "id", code = "code", score = "charlson", assign0 = FALSE)
    cx3 <- comorbidity(x = x3, id = "id", code = "code", score = "charlson", assign0 = FALSE)
    cx4 <- comorbidity(x = x4, id = "id", code = "code", score = "charlson", assign0 = FALSE)
    ex <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
    ex2 <- comorbidity(x = x2, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
    ex3 <- comorbidity(x = x3, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
    ex4 <- comorbidity(x = x4, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
    expect_equal(object = cx, expected = cx2)
    expect_equal(object = cx, expected = cx3)
    expect_equal(object = cx, expected = cx4)
    expect_equal(object = cx2, expected = cx3)
    expect_equal(object = cx2, expected = cx4)
    expect_equal(object = cx3, expected = cx4)
    expect_true(object = all(cx[2:18] >= 0 & cx[2:18] <= 1))
    expect_true(object = all(cx2[2:18] >= 0 & cx2[2:18] <= 1))
    expect_true(object = all(cx3[2:18] >= 0 & cx3[2:18] <= 1))
    expect_true(object = all(cx4[2:18] >= 0 & cx4[2:18] <= 1))
    expect_equal(object = ex, expected = ex2)
    expect_equal(object = ex, expected = ex3)
    expect_equal(object = ex, expected = ex4)
    expect_equal(object = ex2, expected = ex3)
    expect_equal(object = ex2, expected = ex4)
    expect_equal(object = ex3, expected = ex4)
    expect_true(object = all(ex[2:32] >= 0 & ex[2:32] <= 1))
    expect_true(object = all(ex2[2:32] >= 0 & ex2[2:32] <= 1))
    expect_true(object = all(ex3[2:32] >= 0 & ex3[2:32] <= 1))
    expect_true(object = all(ex4[2:32] >= 0 & ex4[2:32] <= 1))
  }

  for (i in seq(100)) {
    x <- data.frame(
      id = sample(1:20, size = 300, replace = TRUE),
      code = sample_diag(300),
      version = "ICD9_2015",
      stringsAsFactors = FALSE
    )
    x2 <- rbind(x, x)
    x3 <- rbind(x, x, x)
    x4 <- rbind(x, x, x, x)
    cx <- comorbidity(x = x, id = "id", code = "code", icd = "icd9", score = "charlson", assign0 = FALSE)
    cx2 <- comorbidity(x = x2, id = "id", code = "code", icd = "icd9", score = "charlson", assign0 = FALSE)
    cx3 <- comorbidity(x = x3, id = "id", code = "code", icd = "icd9", score = "charlson", assign0 = FALSE)
    cx4 <- comorbidity(x = x4, id = "id", code = "code", icd = "icd9", score = "charlson", assign0 = FALSE)
    ex <- comorbidity(x = x, id = "id", code = "code", icd = "icd9", score = "elixhauser", assign0 = FALSE)
    ex2 <- comorbidity(x = x2, id = "id", code = "code", icd = "icd9", score = "elixhauser", assign0 = FALSE)
    ex3 <- comorbidity(x = x3, id = "id", code = "code", icd = "icd9", score = "elixhauser", assign0 = FALSE)
    ex4 <- comorbidity(x = x4, id = "id", code = "code", icd = "icd9", score = "elixhauser", assign0 = FALSE)
    expect_equal(object = cx, expected = cx2)
    expect_equal(object = cx, expected = cx3)
    expect_equal(object = cx, expected = cx4)
    expect_equal(object = cx2, expected = cx3)
    expect_equal(object = cx2, expected = cx4)
    expect_equal(object = cx3, expected = cx4)
    expect_true(object = all(cx[2:18] >= 0 & cx[2:18] <= 1))
    expect_true(object = all(cx2[2:18] >= 0 & cx2[2:18] <= 1))
    expect_true(object = all(cx3[2:18] >= 0 & cx3[2:18] <= 1))
    expect_true(object = all(cx4[2:18] >= 0 & cx4[2:18] <= 1))
    expect_equal(object = ex, expected = ex2)
    expect_equal(object = ex, expected = ex3)
    expect_equal(object = ex, expected = ex4)
    expect_equal(object = ex2, expected = ex3)
    expect_equal(object = ex2, expected = ex4)
    expect_equal(object = ex3, expected = ex4)
    expect_true(object = all(ex[2:32] >= 0 & ex[2:32] <= 1))
    expect_true(object = all(ex2[2:32] >= 0 & ex2[2:32] <= 1))
    expect_true(object = all(ex3[2:32] >= 0 & ex3[2:32] <= 1))
    expect_true(object = all(ex4[2:32] >= 0 & ex4[2:32] <= 1))
  }
})

test_that("input dataset with additional columns", {
  x <- data.frame(
    id = sample(1:20, size = 3000, replace = TRUE),
    code = sample_diag(3000),
    stringsAsFactors = FALSE
  )
  x2 <- x
  x2$noise <- rnorm(n = nrow(x2))
  c <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  c2 <- comorbidity(x = x2, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = c2, expected = c)
  e <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
  e2 <- comorbidity(x = x2, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
  expect_equal(object = e2, expected = e)

  x <- data.frame(
    id = sample(1:20, size = 3000, replace = TRUE),
    code = sample_diag(3000),
    version = "ICD9_2015",
    stringsAsFactors = FALSE
  )
  x2 <- x
  x2$noise <- rnorm(n = nrow(x2))
  c <- comorbidity(x = x, id = "id", code = "code", icd = "icd9", score = "charlson", assign0 = FALSE)
  c2 <- comorbidity(x = x2, id = "id", code = "code", icd = "icd9", score = "charlson", assign0 = FALSE)
  expect_equal(object = c2, expected = c)
  e <- comorbidity(x = x, id = "id", code = "code", icd = "icd9", score = "elixhauser", assign0 = FALSE)
  e2 <- comorbidity(x = x2, id = "id", code = "code", icd = "icd9", score = "elixhauser", assign0 = FALSE)
  expect_equal(object = e2, expected = e)
})

test_that("all comorbidities", {
  data("icd10_2011", package = "comorbidity")
  icd10_2011$id <- 1
  c <- comorbidity(x = icd10_2011, id = "id", code = "Code", icd = "icd10", score = "charlson", assign0 = T)
  e <- comorbidity(x = icd10_2011, id = "id", code = "Code", icd = "icd10", score = "elixhauser", assign0 = T)
  expect_true(object = all(c[2:18] == 1))
  expect_true(object = all(e[2:32] == 1))
  data("icd10_2009", package = "comorbidity")
  icd10_2009$id <- 1
  c <- comorbidity(x = icd10_2009, id = "id", code = "Code", icd = "icd10", score = "charlson", assign0 = T)
  e <- comorbidity(x = icd10_2009, id = "id", code = "Code", icd = "icd10", score = "elixhauser", assign0 = T)
  expect_true(object = all(c[2:18] == 1))
  expect_true(object = all(e[2:32] == 1))
  data("icd9_2015", package = "comorbidity")
  icd9_2015$id <- 1
  c <- comorbidity(x = icd9_2015, id = "id", code = "Code", icd = "icd9", score = "charlson", assign0 = T)
  e <- comorbidity(x = icd9_2015, id = "id", code = "Code", icd = "icd9", score = "elixhauser", assign0 = T)
  expect_true(object = all(c[2:18] == 1))
  expect_true(object = all(e[2:32] == 1))
})

test_that("break output checks", {
  x <- data.frame(
    id = sample(1:20, size = 300, replace = TRUE),
    code = sample_diag(300),
    stringsAsFactors = FALSE
  )
  cx <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  cx[2:18] <- cx[2:18] + rnorm(n = nrow(cx))
  expect_error(.check_output(x = cx, id = "id", score = "charlson"), regexp = "unexpected state")
  ex <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", assign0 = FALSE)
  ex[2:32] <- ex[2:32] + rnorm(n = nrow(ex))
  expect_error(.check_output(x = ex, id = "id", score = "elixhauser"), regexp = "unexpected state")
})
