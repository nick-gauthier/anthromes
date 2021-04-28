test_that('anthrome classifier works', {
  expect_equal(anthrome_classify(hyde_med, inputs_med), anthromes_med)
})
