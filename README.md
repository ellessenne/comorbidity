
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comorbidity <img src="man/figures/hex.png" width = "150" align="right" />

2018-10-08

[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ellessenne/comorbidity?branch=master&svg=true)](https://ci.appveyor.com/project/ellessenne/comorbidity)
[![Travis-CI Build
Status](https://travis-ci.org/ellessenne/comorbidity.svg?branch=master)](https://travis-ci.org/ellessenne/comorbidity)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ellessenne/comorbidity/master.svg)](https://codecov.io/github/ellessenne/comorbidity?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/comorbidity)](https://cran.r-project.org/package=comorbidity)
[![CRAN\_Logs\_Badge](http://cranlogs.r-pkg.org/badges/comorbidity)](https://cran.r-project.org/package=comorbidity)
[![CRAN\_Logs\_Badge\_Total](http://cranlogs.r-pkg.org/badges/grand-total/comorbidity)](https://cran.r-project.org/package=comorbidity)
[![JOSS
DOI](http://joss.theoj.org/papers/10.21105/joss.00648/status.svg)](https://doi.org/10.21105/joss.00648)
[![Zenodo
DOI](https://zenodo.org/badge/68221970.svg)](https://zenodo.org/badge/latestdoi/68221970)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

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
# install.packages("devtools")
devtools::install_github("ellessenne/comorbidity")
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
  code = sample_diag(n = 50),
  stringsAsFactors = FALSE
)
x <- x[order(x$id, x$code), ]
print(head(x, n = 15), row.names = FALSE)
#>  id code
#>   1 C838
#>   1  H30
#>   1 I260
#>   1 I469
#>   1 K611
#>   1 L949
#>   1  V09
#>   2 B677
#>   2 C081
#>   2 I446
#>   2 K225
#>   2  M41
#>   2 M430
#>   2 T635
#>   2 U016
```

It is also possible to simulate from two different versions of the
ICD-10 coding system. The default is to simulate ICD-10 codes from the
2011 version:

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

## Simulating ICD-9 codes

ICD-9 codes can be easily simulated too:

``` r
set.seed(2)
x9 <- data.frame(
  id = sample(1:3, size = 30, replace = TRUE),
  code = sample_diag(n = 30, version = "ICD9_2015"),
  stringsAsFactors = FALSE
)
x9 <- x9[order(x9$id, x9$code), ]
print(head(x9, n = 15), row.names = FALSE)
#>  id  code
#>   1 01161
#>   1  2535
#>   1 37854
#>   1 46451
#>   1 83664
#>   1 94433
#>   1  9711
#>   1 E8038
#>   1 E8498
#>   1  V092
#>   2 01092
#>   2 01301
#>   2  2337
#>   2 37033
#>   2 67450
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
  code = sample_diag(n = 30),
  stringsAsFactors = FALSE
)
```

We could compute the Charlson score, index, and each comorbidity
domain:

``` r
charlson <- comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd10")
charlson
#>   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc
#> 1  1   0   0   0    0        0    0      0   0   1    0      0  0    0    0
#> 2  2   0   0   0    0        0    0      0   0   0    0      0  0    1    1
#> 3  3   0   0   0    0        0    0      0   0   0    0      0  0    0    0
#>   msld metacanc aids score index wscore windex
#> 1    0        0    0     1   1-2      1    1-2
#> 2    0        0    0     2   1-2      4    3-4
#> 3    0        0    0     0     0      0      0
```

The default is to assume ICD-10
codes:

``` r
charlson.default <- comorbidity(x = x, id = "id", code = "code", score = "charlson")
all.equal(charlson, charlson.default)
#> [1] TRUE
```

Alternatively, we could compute the Elixhauser
score:

``` r
elixhauser <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", icd = "icd10")
elixhauser
#>   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf
#> 1  1   0     0    0   0   0      0    0    0   0   0       0     0       0  0
#> 2  2   0     0    0   0   0      0    0    0   0   0       0     0       0  1
#> 3  3   0     0    0   0   0      0    0    0   0   0       0     0       0  0
#>   ld pud aids lymph metacanc solidtum rheumd coag obes wloss fed blane dane
#> 1  1   0    0     0        0        0      0    0    0     0   0     0    0
#> 2  0   0    0     0        0        1      0    0    0     0   0     0    0
#> 3  0   0    0     0        0        0      0    0    0     0   0     0    0
#>   alcohol drug psycho depre score index wscore windex
#> 1       0    0      0     0     1   1-4      4    1-4
#> 2       0    0      0     0     2   1-4     13    >=5
#> 3       0    0      0     0     0     0      0      0
```

Conversely, say we have 5 individuals with a total of 100 ICD-9
diagnostic codes:

``` r
set.seed(3)
x <- data.frame(
  id = sample(1:5, size = 100, replace = TRUE),
  code = sample_diag(n = 100, version = "ICD9_2015"),
  stringsAsFactors = FALSE
)
```

The Charlson and Elixhauser comorbidity codes can be easily computed:

We could compute the Charlson score, index, and each comorbidity
domain:

``` r
charlson9 <- comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd9")
charlson9
#>   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc
#> 1  1   0   0   0    0        0    0      0   0   0    0      0  0    0    1
#> 2  2   0   0   0    0        0    0      0   0   0    0      1  0    0    1
#> 3  3   0   0   0    0        0    0      0   0   0    1      0  0    0    1
#> 4  4   1   0   0    0        0    0      0   0   0    0      0  0    0    1
#> 5  5   0   0   0    0        0    0      0   0   0    0      0  0    0    1
#>   msld metacanc aids score index wscore windex
#> 1    0        0    0     1   1-2      2    1-2
#> 2    1        0    0     3   3-4      7    >=5
#> 3    0        0    0     2   1-2      3    3-4
#> 4    0        0    0     2   1-2      3    3-4
#> 5    0        0    0     1   1-2      2    1-2
```

Alternatively, we could compute the Elixhauser
score:

``` r
elixhauser9 <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", icd = "icd9")
elixhauser9
#>   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf
#> 1  1   0     0    0   0   0      0    0    0   0   0       0     0       0  0
#> 2  2   0     0    0   0   0      0    0    0   0   0       0     1       0  0
#> 3  3   0     0    0   0   0      0    0    0   0   0       0     1       0  0
#> 4  4   0     0    0   0   0      0    1    0   0   0       0     0       0  0
#> 5  5   0     0    0   1   0      0    0    0   0   0       0     0       0  0
#>   ld pud aids lymph metacanc solidtum rheumd coag obes wloss fed blane dane
#> 1  0   0    0     0        0        1      0    0    0     0   0     0    0
#> 2  1   0    0     1        0        1      0    0    0     0   0     0    0
#> 3  0   0    0     1        0        0      0    0    0     0   0     0    0
#> 4  0   0    0     0        0        1      0    0    0     0   0     0    0
#> 5  0   0    0     0        0        1      0    0    0     0   0     0    0
#>   alcohol drug psycho depre score index wscore windex
#> 1       0    0      0     0     1   1-4      7    >=5
#> 2       0    1      0     0     5   >=5      7    >=5
#> 3       1    0      0     0     3   1-4      2    1-4
#> 4       0    0      0     1     3   1-4      1    1-4
#> 5       0    0      0     0     2   1-4     13    >=5
```

## Citation

If you find `comorbidity` useful, please cite it in your publications:

``` r
citation("comorbidity")
#> 
#> To cite the comorbidity package in publications, please use:
#> 
#>   Gasparini, (2018). comorbidity: An R package for computing
#>   comorbidity scores. Journal of Open Source Software, 3(23), 648,
#>   https://doi.org/10.21105/joss.00648
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Article{,
#>     author = {Alessandro Gasparini},
#>     title = {comorbidity: An R package for computing comorbidity scores},
#>     journal = {Journal of Open Source Software},
#>     year = {2018},
#>     volume = {3},
#>     issue = {23},
#>     pages = {648},
#>     doi = {10.21105/joss.00648},
#>     url = {https://doi.org/10.21105/joss.00648},
#>   }
```

## References

This package is based on the ICD-10-based formulations of the Charlson
score and Elixhauser score proposed by Quan *et al*. in 2005. The ICD-9
formulation of the Charlson score is also from Quan *et al*. The
ICD-9-based Elixhauser score is according to the AHRQ formulation (Moore
*et al*., 2017). Weights for the Charlson score are based on the
original formulation by Charlson *et al*. in 1987, while weights for the
Elixhauser score are based on work by van Walraven *et al*. Finally, the
categorisation of scores and weighted scores is based on work by
Menendez *et al*.

  - Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi JC, et
    al. *Coding algorithms for defining comorbidities in ICD-9-CM and
    ICD-10 administrative data*. Medical Care 2005; 43(11):1130-1139.
    DOI:
    [10.1097/01.mlr.0000182534.19832.83](https://doi.org/10.1097/01.mlr.0000182534.19832.83)
  - Charlson ME, Pompei P, Ales KL, et al. *A new method of classifying
    prognostic comorbidity in longitudinal studies: development and
    validation*. Journal of Chronic Diseases 1987; 40:373-383. DOI:
    [10.1016/0021-9681(87)90171-8](https://doi.org/10.1016/0021-9681\(87\)90171-8)
  - Moore BJ, White S, Washington R, Coenen N, and Elixhauser A.
    *Identifying increased risk of readmission and in-hospital mortality
    using hospital administrative data: the AHRQ Elixhauser comorbidity
    index*. Medical Care 2017; 55(7):698-705. DOI:
    [10.1097/MLR.0000000000000735](https://doi.org/10.1097/MLR.0000000000000735)
  - Elixhauser A, Steiner C, Harris DR and Coffey RM. *Comorbidity
    measures for use with administrative data*. Medical Care 1998;
    36(1):8-27. DOI:
    [10.1097/00005650-199801000-00004](https://doi.org/10.1097/00005650-199801000-00004)
  - van Walraven C, Austin PC, Jennings A, Quan H and Forster AJ. *A
    modification of the Elixhauser comorbidity measures into a point
    system for hospital death using administrative data*. Medical Care
    2009; 47(6):626-633. DOI:
    [10.1097/mlr.0b013e31819432e5](https://doi.org/10.1097/mlr.0b013e31819432e5)
  - Menendez ME, Neuhaus V, van Dijk CN, Ring D. *The Elixhauser
    comorbidity method outperforms the Charlson index in predicting
    inpatient death after orthopaedic surgery*. Clinical Orthopaedics
    and Related Research 2014; 472(9):2878-2886. DOI:
    [10.1007/s11999-014-3686-7](https://doi.org/10.1007/s11999-014-3686-7)

## Copyright

The icon for the hex sticker was made by
[Freepik](http://www.freepik.com) from
[Flaticon](https://www.flaticon.com) and is licensed by [CC 3.0
BY](http://creativecommons.org/licenses/by/3.0/).
