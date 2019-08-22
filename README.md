# QuantileNPCI

<!-- badges: start -->
<!-- badges: end -->

The goal of QuantileNPCI is to calculate nonparametric confidence intervals for quantiles using fractional order statistics.

## Installation

You can install the released version of QuantileNPCI from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("QuantileNPCI")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(QuantileNPCI)
quantCI(flood[flood$loc=="Feather", "discharge"], quant=0.5, alpha=0.05, method = "exact")
```

