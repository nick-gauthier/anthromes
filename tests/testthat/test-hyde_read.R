test_that('hyde_read() fails if data-raw not available', {
  expect_error(hyde_read())
})
