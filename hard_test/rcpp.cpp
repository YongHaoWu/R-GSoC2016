#include <Rcpp.h>
#include <cmath>
using namespace Rcpp;

// [[Rcpp::export]]
bool allC(NumericVector x) {
  int n = x.size();

  for(int i = 0; i < n; ++i) {
      if(!x[i])
          return false;
  }
  return true;
}

// [[Rcpp::export]]
NumericVector cumsumC(NumericVector x) {
  int n = x.size();
  bool have_na = 0;
  NumericVector res(n);
  res[0] = x[0];
  for(int i = 1; i < n; ++i) {
      if(NumericVector::is_na(x[i]))
          have_na = 1;
      if(have_na)
          res[i] = nan("");
      else
          res[i] = res[i-1] + x[i];
  }
  return res;
}

/*** R
library(microbenchmark)
range(x <- sort(round(stats::rnorm(10) - 1.2, 1)))
if(all(x < 0)) cat("all x values are negative\n")
if(allC(x < 0)) cat("all x values are negative\n")
microbenchmark(
  all(x<0),
  allC(x<0)
)
cumsum (2:14)
cumsumC(2:14)
cumsum (7)
cumsumC(7)
cumsum(c(1, 3, 7, NA, 8, 11))
cumsumC(c(1, 3, 7, NA, 8, 11))
microbenchmark(
  cumsum (1:10000),
  cumsumC(1:10000)
)

*/
