test_that("exact_extract works", {
  expect_snapshot_output(dgg_extract(hyde_med, dgg_med, 'crops', fun = 'sum'))
})
