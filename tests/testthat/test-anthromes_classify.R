test_that('anthrome classifier works', {
  expect_equal(get_anthromes(hyde_med, inputs_med), anthromes_med)
})
