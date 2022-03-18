rgx <- list(
  fruit = "Apple|Banana",
  vegetable = "Spinach|Kale"
)

test_that("matchit returns the expected results", {
  x <- data.table::data.table(
    ID = 1,
    CODE = "Apple"
  )
  expect_equal(object = comorbidity:::.matchit(x = x, id = "ID", code = "CODE", regex = rgx)$fruit, expected = 1)
  expect_equal(object = comorbidity:::.matchit(x = x, id = "ID", code = "CODE", regex = rgx)$vegetable, expected = 0)
  #
  x <- data.table::data.table(
    ID = 1,
    CODE = "Tomato"
  )
  expect_equal(object = comorbidity:::.matchit(x = x, id = "ID", code = "CODE", regex = rgx)$fruit, expected = 0)
  expect_equal(object = comorbidity:::.matchit(x = x, id = "ID", code = "CODE", regex = rgx)$vegetable, expected = 0)
  #
  x <- data.table::data.table(
    ID = 1,
    CODE = "Kale"
  )
  expect_equal(object = comorbidity:::.matchit(x = x, id = "ID", code = "CODE", regex = rgx)$fruit, expected = 0)
  expect_equal(object = comorbidity:::.matchit(x = x, id = "ID", code = "CODE", regex = rgx)$vegetable, expected = 1)
})
