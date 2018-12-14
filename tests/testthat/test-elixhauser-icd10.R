context("ICD-10 codes for the Elixhauser score are properly identified")

test_that("Elixhauser, chf, I099", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I099"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, chf, I110", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I110"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, chf, I130", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I130"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, chf, I132", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I132"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, chf, I255", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I255"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, chf, I420", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I420"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, chf, I425-429", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I425"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I426"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 2)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I427"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I428"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I429"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, chf, I43", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I43"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, chf, I50", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I50"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, chf, P290", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "P290"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, I441-443", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I441"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I442"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I443"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, I456", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I456"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, I459", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I459"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, I47-49", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I47"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I48"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I49"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, R000", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "R000"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, R001", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "R001"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, R008", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "R008"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, T821", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "T821"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, Z450", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z450"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, carit, Z950", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z950"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$carit, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, A520", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "A520"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, I05-08", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I05"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I06"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I07"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I08"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, I091", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I091"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, I098", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I098"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, I34-39", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I34"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I35"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I36"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I37"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I38"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I39"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, Q230-233", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Q230"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Q231"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Q232"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Q233"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, valv, Z952-954", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z952"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z953"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z954"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$valv, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pcd, I26", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I26"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pcd, I27", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I27"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pcd, I280", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I280"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pcd, I288", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I288"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pcd, I289", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I289"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I70", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I70"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I71", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I71"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I731", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I731"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I738", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I738"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I739", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I739"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I771", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I771"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I790", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I790"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, I792", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I792"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, K551", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K551"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, K558", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K558"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, K559", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K559"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, Z958", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z958"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pvd, Z959", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z959"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pvd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, hypunc, I10", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I10"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, hypc, I11-13", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I11"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I12"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I13"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, hypc, I15", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I15"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G041", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G041"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G114", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G114"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, para, G801", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G801"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G802", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G802"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G81", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G81"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G82", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G82"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G830-834", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G830"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G831"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G832"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G833"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G834"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, para, G839", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G839"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$para, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G10-13", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G10"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G11"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G12"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G13"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G20-22", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G20"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G21"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G22"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G254", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G254"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G255", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G255"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G312", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G312"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G318", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G318"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G319", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G319"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G32", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G32"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G35-37", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G35"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G36"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G37"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G40", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G40"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G41", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G41"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G931", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G931"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, G934", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G934"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, R470", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "R470"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ond, R56", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "R56"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ond, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, cpd, I278", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I278"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, cpd, I279", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I279"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, cpd, J40-47", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I278"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$pcd, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, cpd, J60-67", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J60"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J61"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J62"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J63"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J64"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J65"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J66"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J67"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, cpd, J684", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J684"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, cpd, J701", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J701"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, cpd, J703", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "J703"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$cpd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E100", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E100"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E101", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E101"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E109", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E109"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E110", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E110"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E111", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E111"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E119", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E119"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E120", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E120"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E121", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E121"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E129", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E129"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E130", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E130"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E131", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E131"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E139", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E139"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E140", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E140"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E141", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E141"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabunc, E149", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E149"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabunc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabc, E102-108", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E102"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E103"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E104"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E105"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E106"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E107"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E108"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabc, E112-118", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E112"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E113"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E114"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E115"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E116"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E117"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E118"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabc, E122-128", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E122"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E123"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E124"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E125"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E126"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E127"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E128"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabc, E132-138", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E132"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E133"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E134"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E135"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E136"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E137"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E138"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, diabc, E142-148", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E142"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E143"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E144"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E145"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E146"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E147"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E148"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$diabc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, hypothy, E00-03", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E00"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypothy, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E01"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypothy, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E02"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypothy, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E03"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypothy, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, hypothy, E890", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E890"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$hypothy, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rf, I120", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I120"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, rf, I131", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I131"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$hypc, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, rf, N18", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N18"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rf, N19", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N19"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rf, N250", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "N250"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rf, Z490-492", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z490"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z491"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z492"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rf, Z940", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z940"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rf, Z992", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z992"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rf, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, B18", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B18"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, I85", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I85"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, I864", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I864"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, I982", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I982"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K70", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K70"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K711", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K711"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K713-715", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K713"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K714"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K715"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K717", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K717"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K72-74", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K72"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K73"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K74"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K760", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K760"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, K762-769", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K762"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K763"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K764"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K765"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K766"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K767"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K768"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K769"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, ld, Z944", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z944"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K257", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K257"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K259", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K259"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K267", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K267"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K269", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K269"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K277", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K277"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K279", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K279"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K287", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K287"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, pud, K289", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K289"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$pud, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, aids, B20-22", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B20"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B21"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B22"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, aids, B24", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "B24"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$aids, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, lymph, C81-85", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C81"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C82"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C83"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C84"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C85"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, lymph, C88", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C88"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, lymph, C96", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C96"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, lymph, C900", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C900"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, lymph, C902", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C902"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$lymph, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, metacanc, C77-80", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C77"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C78"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C79"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C80"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$metacanc, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C00-26", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C00"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C01"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C02"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C03"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C04"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C05"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C06"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C07"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C08"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C09"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C10"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C11"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C12"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C13"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C14"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C15"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C16"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C17"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C18"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C19"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C20"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C21"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C22"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C23"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C24"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C25"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C26"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C30-34", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C30"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C31"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C32"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C33"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C34"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C37-41", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C37"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C38"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C39"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C40"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C41"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C43", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C43"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C45-58", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C45"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C46"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C47"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C48"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C49"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C50"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C51"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C52"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C53"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C54"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C55"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C56"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C57"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C58"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C60-76", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C60"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C61"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C62"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C63"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C64"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C65"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C66"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C67"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C68"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C69"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C70"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C71"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C72"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C73"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C74"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C75"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C76"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, solidtum, C97", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "C97"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$solidtum, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, L940", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "L940"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, L941", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "L941"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, L943", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "L943"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M05", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M05"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M06", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M06"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M08", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M08"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M120", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M120"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M123", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M123"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M30", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M30"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M310-313", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M310"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M311"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M312"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M313"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M32-35", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M32"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M33"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M34"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M35"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M45", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M45"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M461", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M461"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M468", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M468"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, rheumd, M469", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "M469"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$rheumd, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, coag, D65-68", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D65"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D66"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D67"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D68"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, coag, D691", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D691"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, coag, D693-696", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D693"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D694"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D695"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D696"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$coag, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, obes, E66", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E66"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$obes, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, wloss, E40-46", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E40"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E41"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E42"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E43"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E44"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E45"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E46"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, wloss, R634", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "R634"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$wloss, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, fed, E222", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E222"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$fed, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, fed, E86", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E86"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$fed, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, fed, E87", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E87"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$fed, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, blane, D500", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D500"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$blane, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, dane, D508", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D508"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$dane, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, dane, D509", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D509"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$dane, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, dane, D51-53", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D51"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$dane, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D52"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$dane, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "D53"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$dane, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, F10", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F10"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, E52", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "E52"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, G621", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "G621"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, I426", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "I426"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$chf, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, alcohol, K292", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K292"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, K700", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K700"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, alcohol, K703", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K703"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, alcohol, K709", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "K709"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$ld, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, alcohol, T51", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "T51"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, Z502", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z502"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, Z714", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z714"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, alcohol, Z721", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z721"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$alcohol, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, drug, F11-16", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F11"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F12"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F13"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F14"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F15"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F16"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, drug, F18", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F18"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, drug, F19", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F19"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, drug, Z715", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z715"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, drug, Z722", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "Z722"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$drug, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F20", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F20"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F22-25", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F22"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F23"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F24"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F25"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F28", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F28"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F29", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F29"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F302", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F302"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F312", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F312"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, psycho, F315", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F315"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, depre, F204", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F204"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, depre, F313-315", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F313"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F314"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F315"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$psycho, expected = 1)
  expect_equal(object = cs$score, expected = 2)
})

test_that("Elixhauser, depre, F32", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F32"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, depre, F33", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F33"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, depre, F341", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F341"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, depre, F412", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F412"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})

test_that("Elixhauser, depre, F432", {
  cs <- comorbidity(x = data.frame(id = "ID1", code = "F432"), id = "id", code = "code", score = "elixhauser")
  expect_equal(object = cs$depre, expected = 1)
  expect_equal(object = cs$score, expected = 1)
})
