test_that('anthrome colors work', {
  expect_length(anthrome_colors(), 21)
  expect_length(anthrome_colors('class'), 21)
  expect_length(anthrome_colors('level'), 7)
  expect_length(anthrome_colors('type'), 4)
  expect_error(anthrome_colors('test'))
  expect_named(anthrome_colors())
})
