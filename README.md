
<!-- README.md is generated from README.Rmd. Please edit that file -->
comorbidity
===========

2018-03-07

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ellessenne/comorbidity?branch=master&svg=true)](https://ci.appveyor.com/project/ellessenne/comorbidity) [![Travis-CI Build Status](https://travis-ci.org/ellessenne/comorbidity.svg?branch=master)](https://travis-ci.org/ellessenne/comorbidity) [![Coverage Status](https://img.shields.io/codecov/c/github/ellessenne/comorbidity/master.svg)](https://codecov.io/github/ellessenne/comorbidity?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/comorbidity)](https://cran.r-project.org/package=comorbidity) [![CRAN\_Logs\_Badge](http://cranlogs.r-pkg.org/badges/comorbidity)](https://cran.r-project.org/package=comorbidity) [![CRAN\_Logs\_Badge\_Total](http://cranlogs.r-pkg.org/badges/grand-total/comorbidity)](https://cran.r-project.org/package=comorbidity) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

`comorbidity` is an R package for computing comorbidity scores such as the weighted Charlson score and the Elixhauser comorbidity score; both ICD-10 and ICD-9 coding systems are supported.

Installation
------------

`comorbidity` is on CRAN. You can install it as usual with:

``` r
install.packages("comorbidity")
```

Alternatively, you can install the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("ellessenne/comorbidity")
```

Simulating ICD-10 codes
-----------------------

With `comorbidity` it is possible to simulate ICD-10 diagnostic codes in a straightforward way:

``` r
# load the comorbidity package
library(comorbidity)
# set a seed for reproducibility
set.seed(1)
# simulate 50 ICD-10 codes for 5 individuals
x <- data.frame(
  id = sample(1:5, size = 50, replace = TRUE),
  code = sample_diag(n = 50),
  stringsAsFactors = FALSE
)
x <- x[order(x$id, x$code), ]
head(x, n = 15)
#>    id code
#> 38  1 C838
#> 12  1  H30
#> 34  1 I260
#> 24  1 I469
#> 10  1 K611
#> 47  1 L949
#> 27  1  V09
#> 5   2 B677
#> 19  2 C081
#> 14  2 I446
#> 28  2 K225
#> 25  2  M41
#> 1   2 M430
#> 22  2 T635
#> 2   2 U016
```

It is also possible to simulate from two different versions of the ICD-10 coding system. The default is to simulate ICD-10 codes from the 2011 version:

``` r
set.seed(1)
x1 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30),
  stringsAsFactors = FALSE
)
set.seed(1)
x2 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD10_2011"),
  stringsAsFactors = FALSE
)
# should return TRUE
all.equal(x1, x2)
#> [1] TRUE
```

Alternatively, you could use the 2009 version:

``` r
set.seed(1)
x1 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD10_2009"),
  stringsAsFactors = FALSE
)
set.seed(1)
x2 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD10_2011"),
  stringsAsFactors = FALSE
)
# should not return TRUE
all.equal(x1, x2)
#> [1] "Component \"code\": 29 string mismatches"
```

Simulating ICD-9 codes
----------------------

ICD-9 codes can be easily simulated too:

``` r
set.seed(2)
x9 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD9_2015"),
  stringsAsFactors = FALSE
)
x9 <- x9[order(x9$id, x9$code), ]
head(x9, n = 15)
#>    id  code
#> 1   1 01161
#> 14  1  2535
#> 12  1 37854
#> 18  1 46451
#> 30  1 83664
#> 27  1 94433
#> 20  1  9711
#> 7   1 E8038
#> 4   1 E8498
#> 24  1  V092
#> 21  2 01092
#> 22  2 01301
#> 10  2  2337
#> 25  2 37033
#> 19  2 67450
```

Computing comorbidity scores
----------------------------

Say we have 3 individuals with a total of 30 ICD-10 diagnostic codes:

``` r
set.seed(1)
x <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30),
  stringsAsFactors = FALSE
)
```

We could compute the Charlson score, index, and each comorbidity domain:

``` r
charlson <- comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")
charlson
#>   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
#> 1  1   0   0   0    0        0    0      0   0   1    0      0  0    0    0    0        0    0
#> 2  2   0   0   0    0        0    0      0   0   0    0      0  0    1    1    0        0    0
#> 3  3   0   0   0    0        0    0      0   0   0    0      0  0    0    0    0        0    0
#>   score index wscore windex
#> 1     1   1-2      1    1-2
#> 2     2   1-2      4    3-4
#> 3     0     0      0      0
```

Alternatively, we could compute the Elixhauser score:

``` r
elixhauser <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10")
elixhauser
#>   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf ld pud aids lymph
#> 1  1   0     0    0   0   0      0    0    0   0   0       0     0       0  0  1   0    0     0
#> 2  2   0     0    0   0   0      0    0    0   0   0       0     0       0  1  0   0    0     0
#> 3  3   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
#>   metacanc solidtum rheumd coag obes wloss fed blane dane alcohol drug psycho depre score index
#> 1        0        0      0    0    0     0   0     0    0       0    0      0     0     1   1-4
#> 2        0        1      0    0    0     0   0     0    0       0    0      0     0     2   1-4
#> 3        0        0      0    0    0     0   0     0    0       0    0      0     0     0     0
#>   wscore windex
#> 1     11    >=5
#> 2      9    >=5
#> 3      0      0
```

Conversely, say we have 5 individuals with a total of 100 ICD-9 diagnostic codes:

``` r
set.seed(3)
x <- data.frame(
  id = sample(1:5, size = 100, replace = TRUE),
  code = sample_diag(n = 100, version = "ICD9_2015"),
  stringsAsFactors = FALSE
)
```

The Charlson and Elixhauser comorbidity codes can be easily computed:

We could compute the Charlson score, index, and each comorbidity domain:

``` r
charlson9 <- comorbidity(x = x9, id = "id", code = "code", score = "charlson_icd9")
charlson9
#>   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
#> 1  1   0   0   0    0        0    0      0   0   0    0      0  0    0    0    0        0    0
#> 2  2   0   0   0    0        0    0      0   0   0    0      0  0    0    0    0        0    0
#> 3  3   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    0
#>   score index wscore windex
#> 1     0     0      0      0
#> 2     0     0      0      0
#> 3     1   1-2      2    1-2
```

Alternatively, we could compute the Elixhauser score:

``` r
elixhauser9 <- comorbidity(x = x9, id = "id", code = "code", score = "elixhauser_icd9")
elixhauser9
#>   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf ld pud aids lymph
#> 1  1   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
#> 2  2   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
#> 3  3   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     1
#>   metacanc solidtum rheumd coag obes wloss fed blane dane alcohol drug psycho depre score index
#> 1        0        0      0    0    0     0   0     0    0       0    0      0     0     0     0
#> 2        0        0      0    0    0     0   0     0    0       0    0      0     0     0     0
#> 3        0        0      0    0    0     0   0     0    0       0    0      0     0     1   1-4
#>   wscore windex
#> 1      0      0
#> 2      0      0
#> 3      9    >=5
```

References
----------

This package is based on the ICD-10-based formulations of the Charlson score and Elixhauser score proposed by Quan *et al*. in 2005. The ICD-9 formulation of the Charlson score is also from Quan *et al*. The ICD-9-based Elixhauser score is according to the AHRQ formulation (Moore *et al*., 2017). Weights for the Charlson score are based on the original formulation by Charlson *et al*. in 1987, while weights for the Elixhauser score are based on work by van Walraven *et al*. Finally, the categorisation of scores and weighted scores is based on work by Menendez *et al*.

-   Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi JC, et al. *Coding algorithms for defining comorbidities in ICD-9-CM and ICD-10 administrative data*. Medical Care 2005; 43(11):1130-1139. DOI: [10.1097/01.mlr.0000182534.19832.83](https://doi.org/10.1097/01.mlr.0000182534.19832.83)
-   Charlson ME, Pompei P, Ales KL, et al. *A new method of classifying prognostic comorbidity in longitudinal studies: development and validation*. Journal of Chronic Diseases 1987; 40:373-383. DOI: [10.1016/0021-9681(87)90171-8](https://doi.org/10.1016/0021-9681(87)90171-8)
-   Moore BJ, White S, Washington R, Coenen N, and Elixhauser A. *Identifying increased risk of readmission and in-hospital mortality using hospital administrative data: the AHRQ Elixhauser comorbidity index*. Medical Care 2017; 55(7):698-705. DOI: [10.1097/MLR.0000000000000735](https://doi.org/10.1097/MLR.0000000000000735)
-   Elixhauser A, Steiner C, Harris DR and Coffey RM. *Comorbidity measures for use with administrative data*. Medical Care 1998; 36(1):8-27. DOI: [10.1097/00005650-199801000-00004](https://doi.org/10.1097/00005650-199801000-00004)
-   van Walraven C, Austin PC, Jennings A, Quan H and Forster AJ. *A modification of the Elixhauser comorbidity measures into a point system for hospital death using administrative data*. Medical Care 2009; 47(6):626-633. DOI: [10.1097/mlr.0b013e31819432e5](https://doi.org/10.1097/mlr.0b013e31819432e5)
-   Menendez ME, Neuhaus V, van Dijk CN, Ring D. *The Elixhauser comorbidity method outperforms the Charlson index in predicting inpatient death after orthopaedic surgery*. Clinical Orthopaedics and Related Research 2014; 472(9):2878-2886. DOI: [10.1007/s11999-014-3686-7](https://doi.org/10.1007/s11999-014-3686-7)
