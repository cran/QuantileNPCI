#' Calculate lower and upper CI of a given quantile using exact method, based on beta distribution
#'
#' @param n sample size
#' @param q quantile
#' @param alpha desired significance level
#'
#' @importFrom stats pbeta uniroot
#'
#' @return a list of the lower and upper confidence limit of the quantiles.Values are between [0,1]
#' \item{u1}{lower confidence limit of the quantile}
#' \item{u2}{upper confidence limit of the quantile}
#'
#' @examples
#' QuantileNPCI:::exactBeta(25, 0.5, 0.05)
#'
exactBeta = function(n, q, alpha){
  # function to estimate the upper and lower bound
  estFun <- function(n, q, b){ # b is targeted lower or upper CI bound
    uniroot(function(x){
      a <- pbeta(q,(n+1)*x,(n+1)*(1-x))
      a - b
    }, c(0,1))
  }
  # lower CI
  u1 <- estFun(n, q, 1 - (alpha/2))
  # upper CI
  u2 <- estFun(n, q, (alpha/2))
  return(list(u1=u1$root, u2=u2$root))
}
