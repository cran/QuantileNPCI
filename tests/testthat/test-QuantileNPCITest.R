
library(QuantileNPCI)          # this will load daved flood data
flood[flood$loc=="Feather", "discharge"]

tbl <- QuantileNPCI:::floodCI  # saved CI. The attribute "quantiles" indicated the corresponding quantiles of the value
qt <- as.numeric(attr(tbl, "quantiles"))/100  # previously quantile saved in 100 scale (percentage)
quant <- .5
alpha <- .05
# quantile calculated by this package
ci <- quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "exact")
ci

test_that("quantCI works", {
  # check the quantiles
  expect_equal(ci$u1, qt[1])
  expect_equal(ci$u2, qt[3])

  # check the corresponding values
  expect_equal(ci$lower.ci, tbl[1])
  expect_equal(ci$qx, tbl[2])
  expect_equal(ci$upper.ci, tbl[3])
})

#call all tests by using test()

test_that("default method in quantCI", {
  # should be the same when use default
  expect_identical(ci, quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha))               # test default method
  expect_identical(ci, quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "e")) # use short term

  expect_type(quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "a"), "list")  # test return proper form
  expect_equal(names(quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "a")$qx), "50th percentile ")
  expect_equivalent(quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "a")$qx,  59200)
  expect_equivalent(quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "a")$lower.ci,  42400)
  expect_equivalent(quantCI(flood[flood$loc=="Feather", "discharge"], quant, alpha, method = "a")$upper.ci,  80700.63,  tolerance = .002)
})
