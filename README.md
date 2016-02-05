# R-GSoC2016
R-GSoC2016 preparation.

- Easy: [[https://github.com/tdhock/regex-tutorial#coding-projects-implementing-functions-for-named-capture][change the benchmark code to test a pattern and subject that you have encountered in one of your own data analyses]], and re-compute the timings figures. Make a package with a vignette that has the benchmark timings figures.
- Medium: [[http://www.rexamine.com/2013/04/properly-internationalized-regular-expressions-in-r/][read Marek's blog post about internationalized/unicode regular expressions]], and write some R code that tests for unicode support in each of the 3 currently available regex engines (PCRE, TRE, ICU).
- Hard: demonstrate that you know how to interface C++ code with R by writing a package with a function that calls some custom C++ code (e.g., try to call =stri_enc_toutf8= from the latest [[https://github.com/Rexamine/stringi/][stringi-devel]] C API from within C++ code).
