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

work_space_path <- getwd()
cpp_path <- paste0(work_space_path, '/hard_test/rcpp.cpp')
sourceCpp(cpp_path)


stri_path <- paste0(work_space_path, '/hard_test/stri_stringi.so')
stri_path
dyn.load(stri_path)
encoding_path <- paste0(work_space_path, '/hard_test/stri_encoding_conversion.so')
dyn.load(encoding_path)
stri_enc_toutf8("abc")

stri_enc_toutf8_test <- function(str, is_unknown_8bit=FALSE, validate=FALSE) {
  .Call(stri_enc_toutf8, str, is_unknown_8bit, validate)
}
stri_enc_toutf8_test("abc")

.Call('stri_enc_toutf8', str="abc")


system("R CMD SHLIB hard_test/fancy_cumsum.cpp")
fancy_cumsum_path <- paste0(work_space_path, '/hard_test/fancy_cumsum.so')
dyn.load(fancy_cumsum_path)
.Call('fancy_cumsum', x=as.double(312))

