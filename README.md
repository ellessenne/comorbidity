
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comorbidity <img src="man/figures/hex.png" width = "150" align="right" />

2019-10-15

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
  code = sample_diag(n = 50),
  stringsAsFactors = FALSE
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
## [1] TRUE
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
## [1] "Component \"code\": 30 string mismatches"
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
  code = sample_diag(n = 30),
  stringsAsFactors = FALSE
)
```

We could compute the Charlson score, index, and each comorbidity domain:

``` r
charlson <- comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd10", assign0 = FALSE)
charlson
##   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
## 1  1   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    1
## 2  2   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    0
## 3  3   0   0   0    0        0    0      0   0   0    0      0  0    0    0    0        0    0
##   score index wscore windex
## 1     2   1-2      8    >=5
## 2     1   1-2      2    1-2
## 3     0     0      0      0
```

We set the `assign0` argument to `FALSE` to not apply a hierarchy of
comorbidity codes, as described in `?comorbidity::comorbidity`. The
default is to assume ICD-10 codes are passed to `comorbidity`:

``` r
charlson.default <- comorbidity(x = x, id = "id", code = "code", score = "charlson", assign0 = FALSE)
all.equal(charlson, charlson.default)
## [1] TRUE
```

Alternatively, we could compute the Elixhauser score:

``` r
elixhauser <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", icd = "icd10", assign0 = FALSE)
elixhauser
##   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf ld pud aids lymph
## 1  1   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    1     0
## 2  2   0     0    1   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
## 3  3   0     0    0   0   0      0    0    0   1   0       0     0       0  0  0   0    0     0
##   metacanc solidtum rheumd coag obes wloss fed blane dane alcohol drug psycho depre score index
## 1        0        1      0    0    0     0   0     0    0       0    0      0     0     2   1-4
## 2        0        1      0    0    0     0   0     0    0       0    0      0     0     2   1-4
## 3        0        0      0    0    0     0   0     0    0       0    0      0     0     1   1-4
##   wscore_ahrq wscore_vw windex_ahrq windex_vw
## 1           7         4         >=5       1-4
## 2           7         3         >=5       1-4
## 3           5         6         >=5       >=5
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

We could compute the Charlson score, index, and each comorbidity domain:

``` r
charlson9 <- comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd9", assign0 = FALSE)
charlson9
##   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
## 1  1   0   0   1    0        0    0      0   0   0    0      0  0    0    1    0        0    0
## 2  2   0   0   0    1        0    0      0   0   0    0      0  0    0    0    0        0    0
## 3  3   0   0   0    0        0    0      0   1   0    0      0  0    0    0    0        0    0
## 4  4   0   0   1    1        0    0      0   0   0    0      0  0    0    1    0        0    0
## 5  5   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    0
##   score index wscore windex
## 1     2   1-2      3    3-4
## 2     1   1-2      1    1-2
## 3     1   1-2      1    1-2
## 4     3   3-4      4    3-4
## 5     1   1-2      2    1-2
```

Alternatively, we could compute the Elixhauser score:

``` r
elixhauser9 <- comorbidity(x = x, id = "id", code = "code", score = "elixhauser", icd = "icd9", assign0 = FALSE)
elixhauser9
##   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy rf ld pud aids lymph
## 1  1   0     0    0   0   1      0    0    0   0   0       0     0       0  0  0   0    0     0
## 2  2   0     0    0   0   0      0    0    0   1   0       0     0       0  0  0   0    0     0
## 3  3   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
## 4  4   0     0    0   1   1      0    0    0   0   0       0     0       0  0  0   0    0     0
## 5  5   0     0    0   0   0      0    0    0   0   0       0     0       0  0  0   0    0     0
##   metacanc solidtum rheumd coag obes wloss fed blane dane alcohol drug psycho depre score index
## 1        0        0      0    0    0     0   0     0    0       0    0      0     0     1   1-4
## 2        0        0      0    0    0     0   0     0    0       0    0      0     0     1   1-4
## 3        0        0      0    0    0     0   0     0    0       0    0      1     0     1   1-4
## 4        0        0      0    0    0     0   0     0    0       0    0      0     0     2   1-4
## 5        0        0      1    0    0     0   0     0    0       0    0      0     0     1   1-4
##   wscore_ahrq wscore_vw windex_ahrq windex_vw
## 1           3         2         1-4       1-4
## 2           5         6         >=5       >=5
## 3          -5         0          <0         0
## 4           9         6         >=5       >=5
## 5           0         0           0         0
```

The weighted Elixhauser score is computed using both the AHRQ and the
van Walraven algorithm (`wscore_ahrq` and `wscore_vw`).

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

This package is based on the ICD-10-based formulations of the Charlson
score and Elixhauser score proposed by Quan *et al*. in 2005. The ICD-9
formulation of the Charlson score is also from Quan *et al*. The
ICD-9-based Elixhauser score is according to the AHRQ formulation (Moore
*et al*., 2017). Weights for the Charlson score are based on the
original formulation by Charlson *et al*. in 1987, while weights for the
Elixhauser score are based on work by van Walraven *et al*. Finally, the
categorisation of scores and weighted scores is based on work by
Menendez *et al*. Further details on each algorithm are included in the
package vignette, which you can access by typing the following in the R
console:

``` r
vignette("comorbidityscores", package = "comorbidity")
```

  - Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi JC, et
    al. *Coding algorithms for defining comorbidities in ICD-9-CM and
    ICD-10 administrative data*. Medical Care 2005; 43(11):1130-1139.
    DOI:
    [10.1097/01.mlr.0000182534.19832.83](https://doi.org/10.1097/01.mlr.0000182534.19832.83)
  - Charlson ME, Pompei P, Ales KL, et al. *A new method of classifying
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
[monkik](https://www.flaticon.com/authors/monkik) from
[www.flaticon.com](https://www.flaticon.com), and is licensed by
[Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0).
