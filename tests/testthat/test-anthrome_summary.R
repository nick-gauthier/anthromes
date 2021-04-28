test_that("summaries do not give NAs", {
  expect_false(any(is.na(anthrome_summary(anthromes_med, inputs_med, by = regions))))
  expect_false(any(is.na(hyde_summary(hyde_med, inputs_med, by = regions))))
})


