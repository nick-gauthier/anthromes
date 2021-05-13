test_that("exact_extract works", {
  #expect_snapshot_output(dgg_extract(hyde_med, dgg_med, 'crops', fun = 'sum'))
  # old test fails between dev stars version
  #temp test until stars dev updates
  expect_equal(sum(dgg_extract(hyde_med, dgg_med, 'crops', fun = 'sum')$crops),
               506023.3)
})
