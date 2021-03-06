context("mixing Munsell colors")


test_that("mixMunsell works as expected", {

  ## error conditions
  expect_error(mixMunsell(c(NA, '10YR 3/4')))

  # invalid Munsell notation
  expect_error(mixMunsell(c('10YR 5/3', '10YR 3/99')))

  # singleton
  x <- mixMunsell(c('10YR 5/3'))
  expect_true(inherits(x, 'data.frame'))
  expect_true(ncol(x) == 5)
  expect_true(nrow(x) == 1)
  expect_true(x$munsell == '10YR 5/3')

  # standard usage
  x <- mixMunsell(c('10YR 5/3', '10YR 3/2'))
  expect_true(x$munsell == '10YR 4/2')
  
  # correct output, same as above; using recycled weight length 1
  # munsell   distance
  # 1 10YR 4/2 0.02993819
  
  x <- mixMunsell(c('10YR 5/3', '10YR 3/2'), w = 1)
  expect_true(x$munsell == '10YR 4/2')
  expect_equal(x$distance, 0.0046028, tolerance = 1e-4)

  # weights when length(x) != length(unique(x))
  expect_silent(mixMunsell(c('10YR 5/3', '10YR 3/2', '10YR 5/3')))

  # 0 weights to filter NA
  expect_silent(mixMunsell(c(NA, '10YR 3/4'), w = c(0, 1)))

})

test_that("multiple matches", {
  m <- mixMunsell(c('10YR 6/2', '10YR 2/2'), n = 3)
  
  # verified results
  expect_true(nrow(m) == 3)
  # first match
  expect_true(m$munsell[1] == '10Y 4/3')
  expect_true(m$munsell[2] == '5Y 4/2')
})


test_that("mixed spectra option", {
  mx <- mixMunsell(c('10YR 6/2', '10YR 2/2'), n = 3, keepMixedSpec = TRUE)
  
  # results are a list vs. data.frame
  expect_true(inherits(mx, 'list'))
  
  # mixture candidates are here
  m <- mx$mixed
  
  # verified results
  expect_true(nrow(m) == 3)
  # first match
  expect_true(m$munsell[1] == '10Y 4/3')
  expect_true(m$munsell[2] == '5Y 4/2')
})

test_that("mxing methods", {
  
  ## all reference spectra available
  
  # each method gives a slightly different result
  
  # exact
  mx <- mixMunsell(c('10YR 6/2', '10YR 2/2'), mixingMethod = 'exact')
  expect_true(mx$munsell[1] == '10YR 4/2')
  
  # reference
  mx <- mixMunsell(c('10YR 6/2', '10YR 2/2'), mixingMethod = 'reference')
  expect_true(mx$munsell[1] == '10Y 4/3')
  
  # wt. mean CIELAB, results are slightly different
  mx <- mixMunsell(c('10YR 6/2', '10YR 2/2'), mixingMethod = 'estimate')
  expect_true(mx$munsell[1] == '10YR 4/2')
  
  # adaptive, should get exact mixture
  mx <- mixMunsell(c('10YR 6/2', '10YR 2/2'), mixingMethod = 'adaptive')
  expect_true(mx$munsell[1] == '10YR 4/2')

  ## some reference spectra missing
  
  # message and NA
  expect_message(mx <- mixMunsell(c('10YR 6/2', '10YR 1/1'), mixingMethod = 'reference'))
  expect_true(is.na(mx$munsell[1]))
  
  # fall-back to wt.mean CIELAB
  expect_message(mx <- mixMunsell(c('10YR 6/2', '10YR 1/1'), mixingMethod = 'adaptive'))
  expect_true(mx$munsell[1] == '2.5Y 3/2')
  
})

test_that("additional arguments via ...", {
  
  # NO conversion to closest Munsell chip via rgb2munsell()
  m <- mixMunsell(c('10YR 6/2', '10YR 2/2'), mixingMethod = 'exact', convert = FALSE)
  
  # verified results
  expect_true(nrow(m) == 1)
  
  # additional columns
  expect_true(
    all(c('r', 'g', 'b') %in% names(m))
  )
  
})


