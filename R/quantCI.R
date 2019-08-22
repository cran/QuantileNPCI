#'quantCI
#'
#' @description Calculate nonparametric confidence intervals for quantiles using fractional order statistics,
#'
#' @usage quantCI(x, q, alpha, method)
#'
#' @author Nicholas Hutson
#'
#' @param x vector of data
#' @param q the quantile
#' @param alpha the significance level
#' @param method the method used for calculate the confidence interval. Options are "exact" or "approximate".
#'
#' @return returns a list of 5 values:
#' \item{u1}{the lower confidence limit of the quantile}
#' \item{u2}{the upper confidence limit of the quantile}
#' \item{lower.ci}{the estimated x value at u1}
#' \item{qx}{the estimate x value of at the quantile q}
#' \item{upper.ci}{the estimated x value at u2}
#'
#' @examples
#' x <- c(3.5,2.4,2.1,1.3,1.2,2.2,2.6,4.2)
#' quantCI(x, q=0.5, alpha=0.05, method = "exact")
#'
#' @importFrom stats qbeta
#'
#' @export
quantCI <- function(x, q, alpha, method=c("exact", "approximate")){
  method <- match.arg(method)
  x <- sort(x)
  n <- length(x)

  if(method == "exact"){
    results <- exactBeta(n, q, alpha)
    u1 <- results[[1]]
    u2 <- results[[2]]
  }else if(method == "approximate"){
    pn=(n+1)*q
    qn=(n+1)*(1-q)

    u1 <- qbeta(alpha/2, pn, qn)
    u2 <- qbeta(1 - alpha/2, pn, qn)
  }else{
    stop("A method must be entered")
  }

  a <- c(q, u1, u2)
  z <- (n+1)*a
  j <- floor(z)
  g <- z - j
  y <- c()

  for(r in 1:3){
    if(j[r]==0){
      y[r] <- x[1]
    }else if(j[r] > n){
      y[r] <- x[n]
    }else{
      y[r] <- (1-g[r])*x[j[r]] + g[r]*x[j[r]+1]
    }
  }

  tbl <- c(y[1],y[2],y[3])
  names(tbl) <- paste(as.character(a[c(1:3)]*100),"th percentile ", sep = "")
  return(list(u1 = u1, u2 = u2, lower.ci = tbl[2], qx = tbl[1], upper.ci = tbl[3]))
}
