library(Rcpp)
cppFunction('long int w_GCD( long int a, long int b) {
                while(a%b != 0) {
                   int temp = a;
                   a = b;
                   b = temp%b;
                }
                return b;
             }
            ')
w_GCD
w_GCD(312140238, 13121223438)



