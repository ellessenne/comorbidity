context("ICD-10 codes for the Charlson score are properly identified")

test_that("Charlson, ami, I21", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I21"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$ami, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, ami, I22", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I22"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$ami, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, ami, I252", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I252"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$ami, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I099", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I099"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I110", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I110"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I130", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I130"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I132", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I132"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I255", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I255"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I420", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I420"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I425-429", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I425"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I426"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I427"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I428"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I429"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I43", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I43"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, I50", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I50"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, chf, P290", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "P290"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I70", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I70"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I71", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I71"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I731", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I731"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I738", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I738"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I739", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I739"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I771", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I771"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I790", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I790"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, I792", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I792"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, K551", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K551"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, K558", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K558"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, K559", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K559"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, Z958", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z958"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pvd, Z959", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z959"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, cevd, G45", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G45"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, cevd, G46", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G46"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, cevd, H340", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "H340"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, cevd, I60-69", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I60"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I61"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I62"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I63"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I64"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I65"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I66"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I67"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I68"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I69"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$cevd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, dementia, F00-03", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F00"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F01"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F02"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F03"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, dementia, F051", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F051"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, dementia, G30", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G30"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, dementia, G311", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G311"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$dementia, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, I278", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I278"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, I279", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I279"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, J40-47", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J40"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J41"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J42"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J43"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J44"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J45"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J46"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J47"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, J60-67", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J60"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J61"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J62"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J63"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J64"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J65"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J66"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J67"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, J684", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J684"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, J701", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J701"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, copd, J703", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J703"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$copd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M05", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M05"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M06", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M06"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M315", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M315"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M32-34", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M32"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M33"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M34"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M351", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M351"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M353", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M353"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rheumd, M360", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M360"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, pud, K25-28", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K25"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K26"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K27"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K28"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, B18", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B18"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K700-703", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K700"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K701"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K702"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K703"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K709", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K709"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K713-715", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K713"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K714"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K715"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K717", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K717"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K73", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K73"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K74", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K74"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K760", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K760"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K762-764", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K762"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K763"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K764"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K768", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K768"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, K769", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K769"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, mld, Z944", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z944"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$mld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E100", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E100"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E101", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E101"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E106", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E106"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E108", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E108"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E109", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E109"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E110", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E110"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E111", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E111"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E116", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E116"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E118", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E118"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E119", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E119"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E120", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E120"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E121", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E121"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E126", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E126"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E128", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E128"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E129", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E129"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E130", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E130"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E131", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E131"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E136", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E136"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E138", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E138"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E139", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E139"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E140", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E140"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E141", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E141"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E146", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E146"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E148", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E148"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diab, E149", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E149"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diab, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E102-105", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E102"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E103"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E104"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E105"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E107", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E107"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E112-115", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E112"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E113"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E114"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E115"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E117", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E117"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E122-125", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E122"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E123"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E124"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E125"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E127", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E127"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E132-135", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E132"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E133"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E134"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E135"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E137", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E137"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E142-145", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E142"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E143"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E144"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E145"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, diabwc, E147", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E147"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$diabwc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G041", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G041"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G114", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G114"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G801", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G801"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G802", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G802"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G81", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G81"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G82", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G82"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G830-834", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G830"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G831"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G832"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G833"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G834"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, hp, G839", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G839"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$hp, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, I120", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I120"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, I120", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I120"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, I131", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I131"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, N032-073", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N032"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N033"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N034"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N035"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N036"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N037"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, N052-057", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N052"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N053"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N054"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N055"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N056"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N057"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, N18", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N18"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, N19", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N19"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, N250", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N250"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, Z490-492", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z490"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z491"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z492"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, Z940", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z940"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, rend, Z992", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z992"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$rend, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C00-26", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C00"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C01"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C02"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C03"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C04"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C05"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C06"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C07"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C08"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C09"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C10"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C11"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C12"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C13"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C14"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C15"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C16"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C17"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C18"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C19"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C20"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C21"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C22"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C23"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C24"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C25"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C26"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C30-34", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C30"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C31"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C32"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C33"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C34"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C41", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C41"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C43", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C43"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C45-58", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C45"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C46"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C47"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C48"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C49"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C50"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C51"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C52"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C53"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C54"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C55"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C56"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C57"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C58"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C60-76", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C60"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C61"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C62"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C63"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C64"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C65"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C66"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C67"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C68"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C69"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C70"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C71"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C72"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C73"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C74"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C75"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C76"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})
test_that("Charlson, canc, C81-85", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C81"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C82"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C83"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C84"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C85"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C88", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C88"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, canc, C90-97", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C90"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C91"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C92"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C93"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C94"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C95"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C96"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C97"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$canc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, I850", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I850"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, I859", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I859"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, I864", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I864"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, I982", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I982"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K704", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K704"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K711", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K711"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K721", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K721"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K729", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K729"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K765", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K765"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K766", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K766"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, msld, K767", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K767"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$msld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, metacanc, C77-80", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C77"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C78"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C79"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C80"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, aids, B20-22", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B20"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B21"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B22"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Charlson, aids, B24", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B24"), id = "id", code = "code", score = "charlson", assign0 = FALSE)
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})
