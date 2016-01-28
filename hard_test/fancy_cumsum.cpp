#include <R.h>
#include <Rinternals.h>
extern "C" {
    SEXP mkans(double x) {
        SEXP ans;
        PROTECT(ans = allocVector(REALSXP, 1));
        REAL(ans)[0] = x;
        UNPROTECT(1);
        return ans;
    }
    double feval(double x, SEXP f, SEXP rho) {
        defineVar(install("x"), mkans(x), rho);
        return(REAL(eval(f, rho))[0]);
    }
    SEXP myfun(SEXP f, SEXP rho) {
        double x = 7.0;
        double result = feval(x, f, rho);
        return(mkans(result));
    }

    SEXP fancy_cumsum(SEXP x)
    {
        int n = length(x);
        double* rx = REAL(x);
        SEXP res;
        PROTECT(res = allocVector(REALSXP, n));
        REAL(res)[0] = rx[0];
        for(int i = 1; i < n; ++i) {
            REAL(res)[i] = REAL(res)[i-1] + rx[i];
        }
        UNPROTECT(1);
        return res;
        ///        SEXP res;
        ///        PROTECT(res = allocVector(REALSXP, 10));
        ///        REAL(res)[0] =12;
        ///        return res;
    }
}


//    double* rans;
//    SEXP ans, dim, dimnames;
//    PROTECT(ans = allocVector(REALSXP, nx*ny));
//    rans = REAL(ans);
//    for(i = 0; i < nx; i++) {
//        tmp = rx[i];
//        for(j = 0; j < ny; j++)
//            rans[i + nx*j] = tmp * ry[j];
//    }
//    PROTECT(dim = allocVector(INTSXP, 2));
//    INTEGER(dim)[0] = nx; INTEGER(dim)[1] = ny;
//    setAttrib(ans, R_DimSymbol, dim);
//    PROTECT(dimnames = allocVector(VECSXP, 2));
//    SET_VECTOR_ELT(dimnames, 0, getAttrib(x, R_NamesSymbol));
//    SET_VECTOR_ELT(dimnames, 1, getAttrib(y, R_NamesSymbol));
//    setAttrib(ans, R_DimNamesSymbol, dimnames);
//    UNPROTECT(3);
//    return(ans);
//}
