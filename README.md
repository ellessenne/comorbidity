
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The {comorbidity} Package: Computing Comorbidity Scores <img src="man/figures/hex.png" width = "150" align="right" />

Last updated: 2022-09-26 16:24:49

<!-- badges: start -->

[![R build
status](https://github.com/ellessenne/comorbidity/workflows/R-CMD-check/badge.svg)](https://github.com/ellessenne/comorbidity/actions)
[![Codecov test
coverage](https://codecov.io/gh/ellessenne/comorbidity/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ellessenne/comorbidity?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/comorbidity)](https://cran.r-project.org/package=comorbidity)
[![CRAN_Logs_Badge](http://cranlogs.r-pkg.org/badges/comorbidity)](https://cran.r-project.org/package=comorbidity)
[![CRAN_Logs_Badge_Total](http://cranlogs.r-pkg.org/badges/grand-total/comorbidity)](https://cran.r-project.org/package=comorbidity)
[![JOSS
DOI](http://joss.theoj.org/papers/10.21105/joss.00648/status.svg)](https://doi.org/10.21105/joss.00648)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com/)
<!-- badges: end -->

`comorbidity` is an R package for computing comorbidity scores such as
the weighted Charlson score and the Elixhauser comorbidity score; both
ICD-10 and ICD-9 coding systems are supported.

## Installation

`comorbidity` is on CRAN. You can install it as usual with:

``` r
install.packages("comorbidity")
```

Alternatively, you can install the development version from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("ellessenne/comorbidity")
```

## Simulating ICD-10 codes

The `comorbidity` packages includes a function named `sample_diag()`
that allows simulating ICD diagnostic codes in a straightforward way.
For instance, we could simulate ICD-10 codes:

``` r
# load the comorbidity package
library(comorbidity)
# set a seed for reproducibility
set.seed(1)
# simulate 50 ICD-10 codes for 5 individuals
x <- data.frame(
  id = sample(1:5, size = 50, replace = TRUE),
  code = sample_diag(n = 50)
)
x <- x[order(x$id, x$code), ]
print(head(x, n = 15), row.names = FALSE)
##  id code
##   1  B02
##   1 B582
##   1 I749
##   1 J450
##   1 L893
##   1 Q113
##   1  Q26
##   1 Q978
##   1 T224
##   1 V101
##   1 V244
##   1  V46
##   2 A665
##   2 C843
##   2 D838
```

It is also possible to simulate from two different versions of the
ICD-10 coding system. The default is to simulate ICD-10 codes from the
2011 version:

``` r
set.seed(1)
x1 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30)
)
set.seed(1)
x2 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD10_2011")
)
# should return TRUE
all.equal(x1, x2)
## [1] TRUE
```

Alternatively, you could use the 2009 version:

``` r
set.seed(1)
x1 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD10_2009")
)
set.seed(1)
x2 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD10_2011")
)
# should not return TRUE
all.equal(x1, x2)
## [1] "Component \"code\": 30 string mismatches"
```

## Simulating ICD-9 codes

ICD-9 codes can be easily simulated too:

``` r
set.seed(2)
x9 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD9_2015")
)
x9 <- x9[order(x9$id, x9$code), ]
print(head(x9, n = 15), row.names = FALSE)
##  id  code
##   1 01130
##   1 01780
##   1 30151
##   1  3073
##   1 36907
##   1 37845
##   1 64212
##   1 66704
##   1 72633
##   1  9689
##   1  V289
##   2  0502
##   2 09169
##   2 20046
##   2 25082
```

## Computing comorbidity scores

The main function of the `comorbidity` package is named `comorbidity()`,
and it can be used to compute any supported comorbidity score; scores
can be specified by setting the `score` argument, which is required.

Say we have 3 individuals with a total of 30 ICD-10 diagnostic codes:

``` r
set.seed(1)
x <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30)
)
```

We could compute the Charlson comorbidity domains:

``` r
charlson <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd10_quan", assign0 = FALSE)
charlson
##   id mi chf pvd cevd dementia cpd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
## 1  1  0   0   0    0        0   0      0   0   0    0      0  0    0    1    0        0    1
## 2  2  0   0   0    0        0   0      0   0   0    0      0  0    0    1    0        0    0
## 3  3  0   0   0    0        0   0      0   0   0    0      0  0    0    0    0        0    0
```

We set the `assign0` argument to `FALSE` to not apply a hierarchy of
comorbidity codes, as described in `?comorbidity::comorbidity`.

Alternatively, we could compute the Elixhauser score:

``` r
elixhauser <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd10_quan", assign0 = FALSE)
elixhauser
##   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf ld pud aids lymph
## 1  1   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    1     0
## 2  2   0     0    1   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
## 3  3   0     0    0   0   0      0    0    0   1   0       0     0       0  0  0   0    0     0
##   metacanc solidtum rheumd coag obes wloss fed blane dane alcohol drug psycho depre
## 1        0        1      0    0    0     0   0     0    0       0    0      0     0
## 2        0        1      0    0    0     0   0     0    0       0    0      0     0
## 3        0        0      0    0    0     0   0     0    0       0    0      0     0
```

Weighted an unweighted comorbidity scores can be obtained using the
`score()` function:

``` r
unw_cci <- score(charlson, weights = NULL, assign0 = FALSE)
unw_cci
## [1] 2 1 0
## attr(,"map")
## [1] "charlson_icd10_quan"

quan_cci <- score(charlson, weights = "quan", assign0 = FALSE)
quan_cci
## [1] 6 2 0
## attr(,"map")
## [1] "charlson_icd10_quan"
## attr(,"weights")
## [1] "quan"

all.equal(unw_cci, quan_cci)
## [1] "Attributes: < Length mismatch: comparison on first 1 components >"
## [2] "Mean relative difference: 1.666667"
```

Code for the Elixhauser score is omitted, but works analogously.

Conversely, say we have 5 individuals with a total of 100 ICD-9
diagnostic codes:

``` r
set.seed(3)
x <- data.frame(
  id = sample(1:5, size = 100, replace = TRUE),
  code = sample_diag(n = 100, version = "ICD9_2015")
)
```

The Charlson and Elixhauser comorbidity codes can be easily computed
once again:

``` r
charlson9 <- comorbidity(x = x, id = "id", code = "code", map = "charlson_icd9_quan", assign0 = FALSE)
charlson9
##   id mi chf pvd cevd dementia cpd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
## 1  1  0   0   1    0        0   0      0   0   0    0      0  0    0    1    0        0    0
## 2  2  0   0   0    1        0   0      0   0   0    0      0  0    0    0    0        0    0
## 3  3  0   0   0    0        0   0      0   1   0    0      0  0    0    0    0        0    0
## 4  4  0   0   1    1        0   0      0   0   0    0      0  0    0    1    0        0    0
## 5  5  0   0   0    0        0   0      0   0   0    0      0  0    0    1    0        0    0
```

``` r
elixhauser9 <- comorbidity(x = x, id = "id", code = "code", map = "elixhauser_icd9_quan", assign0 = FALSE)
elixhauser9
##   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf ld pud aids lymph
## 1  1   0     0    0   0   1      0    0    0   0   0       0     0       0  0  0   0    0     0
## 2  2   0     0    0   0   0      0    0    0   1   0       0     0       0  0  0   0    0     0
## 3  3   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
## 4  4   0     0    0   1   1      0    0    0   0   0       0     0       0  0  0   0    0     0
## 5  5   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
##   metacanc solidtum rheumd coag obes wloss fed blane dane alcohol drug psycho depre
## 1        0        0      0    0    0     0   0     0    0       0    0      0     0
## 2        0        0      0    0    0     0   0     0    0       0    0      0     0
## 3        0        0      0    0    0     0   0     0    0       0    0      1     0
## 4        0        0      0    0    0     0   0     0    0       0    0      0     0
## 5        0        0      1    0    0     0   0     0    0       0    0      0     0
```

Scores:

``` r
unw_eci <- score(elixhauser9, weights = NULL, assign0 = FALSE)
vw_eci <- score(elixhauser9, weights = "vw", assign0 = FALSE)
all.equal(unw_eci, vw_eci)
## [1] "Attributes: < Length mismatch: comparison on first 1 components >"
## [2] "Mean relative difference: 2"
```

## Citation

If you find `comorbidity` useful, please cite it in your publications:

``` r
citation("comorbidity")
## 
## To cite the comorbidity package in publications, please use:
## 
##   Gasparini, (2018). comorbidity: An R package for computing comorbidity scores. Journal
##   of Open Source Software, 3(23), 648, https://doi.org/10.21105/joss.00648
## 
## A BibTeX entry for LaTeX users is
## 
##   @Article{,
##     author = {Alessandro Gasparini},
##     title = {comorbidity: An R package for computing comorbidity scores},
##     journal = {Journal of Open Source Software},
##     year = {2018},
##     volume = {3},
##     issue = {23},
##     pages = {648},
##     doi = {10.21105/joss.00648},
##     url = {https://doi.org/10.21105/joss.00648},
##   }
```

## References

More details on which comorbidity mapping and scoring algorithm are
available within the package can be found in the two accompanying
vignettes, which can be accessed on CRAN or directly from your R
session:

``` r
vignette("A-introduction", package = "comorbidity")
vignette("B-comorbidity-scores", package = "comorbidity")
```

## Copyright

The icon for the hex sticker was made by
[monkik](https://www.flaticon.com/authors/monkik) from
[www.flaticon.com](https://www.flaticon.com), and is licensed by
[Creative Commons BY 3.0](https://creativecommons.org/licenses/by/3.0).
