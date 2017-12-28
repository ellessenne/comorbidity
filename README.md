
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comorbidity

[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ellessenne/comorbidity?branch=master&svg=true)](https://ci.appveyor.com/project/ellessenne/comorbidity)
[![Travis-CI Build
Status](https://travis-ci.org/ellessenne/comorbidity.svg?branch=master)](https://travis-ci.org/ellessenne/comorbidity)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ellessenne/comorbidity/master.svg)](https://codecov.io/github/ellessenne/comorbidity?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/comorbidity)](https://cran.r-project.org/package=comorbidity)

`comorbidity` is an R package for computing comorbidity scores such as
the weighted Charlson score and the Elixhauser comorbidity score,
assuming ICD-10 diagnostic codes.

## Installation

You can install `comorbidity` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("ellessenne/comorbidity")
```

## Example

This is a basic example which shows you how to solve a common problem.

First, we simulate 150 ICD-10 diagnostic codes for 10 individuals using
the `sample_codes_icd10()` function:

``` r
# load the comorbidity package
library(comorbidity)
# set a seed for reproducibility
set.seed(1)
x <- data.frame(
  id = sample(1:10, size = 150, replace = TRUE),
  code = sample_diag_icd10(150),
  stringsAsFactors = FALSE)
head(x)
#>   id code
#> 1  3 P541
#> 2  4 O088
#> 3  6 I352
#> 4 10 L910
#> 5  3 M880
#> 6  9  E10
```

Then, we compute the Charlson score, index, and each comorbidity
domain:

``` r
charlson = comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")
head(charlson)
#>   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend
#> 1  1   0   0   0    0        0    0      0   0   0    0      1  0    1
#> 2  2   0   0   0    0        0    0      0   1   0    0      0  0    0
#> 3  3   0   0   0    0        0    0      0   0   0    0      1  0    0
#> 4  4   0   0   0    0        0    0      0   0   0    0      0  1    0
#> 5  5   0   0   0    0        0    0      0   0   1    0      0  0    0
#> 6  6   0   0   0    0        0    0      0   0   0    0      0  0    1
#>   canc msld metacanc aids score index wscore windex
#> 1    1    0        0    0     3   3-4      6    >=5
#> 2    1    0        0    0     2   1-2      3    3-4
#> 3    1    0        0    0     2   1-2      4    3-4
#> 4    0    0        0    0     1   1-2      2    1-2
#> 5    1    0        0    0     2   1-2      3    3-4
#> 6    0    0        0    0     1   1-2      2    1-2
```

Analogously, using the Elixhauser
score:

``` r
elixhauser = comorbidity(x = x, id = "id", code = "code", score = "elixhauser_icd10")
head(elixhauser)
#>   id chf carit valv pcd pvd hypunc hypc para ond cpd diabunc diabc hypothy
#> 1  1   0     0    0   0   0      0    0    0   0   0       0     1       0
#> 2  2   0     0    0   0   0      0    0    0   0   0       0     0       0
#> 3  3   0     0    0   0   0      0    0    0   0   0       0     1       0
#> 4  4   0     0    0   0   0      0    1    1   1   0       0     0       0
#> 5  5   0     0    0   0   0      0    0    0   0   0       0     0       0
#> 6  6   0     0    0   0   0      0    1    0   1   0       0     0       0
#>   rf ld pud aids lymph metacanc solidtum rheumd coag obes wloss fed blane
#> 1  1  0   0    0     0        0        1      0    0    0     0   0     0
#> 2  0  0   0    0     0        0        1      0    0    0     0   0     0
#> 3  0  0   0    0     0        0        1      0    0    0     0   0     0
#> 4  0  0   0    0     0        0        0      0    0    0     0   0     0
#> 5  0  1   0    0     0        0        1      0    0    0     0   0     0
#> 6  1  0   0    0     0        0        0      0    0    0     0   0     0
#>   dane alcohol drug psycho depre score index wscore windex
#> 1    0       0    0      0     0     3   1-4      9    >=5
#> 2    0       0    0      0     0     1   1-4      4    1-4
#> 3    0       0    0      0     0     2   1-4      4    1-4
#> 4    0       0    0      0     0     3   1-4     13    >=5
#> 5    0       0    0      0     0     2   1-4     15    >=5
#> 6    0       0    1      0     0     4   1-4      4    1-4
```

## References

This package is based on the ICD-10-based formulations of the Charlson
score and Elixhauser score proposed by Quan *et al*. in 2005. Weights
for the Charlson score are based on the original formulation by Charlson
*et al*. in 1987, while weights for the Elixhauser score are based on
work by van Walraven *et al*. Finally, the categorisation of scores and
weighted scores is based on work by Menendez *et al*.

  - Quan H, Sundararajan V, Halfon P, Fong A, Burnand B, Luthi J-C, et
    al. *Coding algorithms for defining comorbidities in ICD-9-CM and
    ICD-10 administrative data*. Medical Care 2005; 43(11):1130-1139.
  - Charlson ME, Pompei P, Ales KL, et al. *A new method of classifying
    prognostic comorbidity in longitudinal studies: development and
    validation*. Journal of Chronic Diseases 1987; 40:373-383.
  - van Walraven C, Austin PC, Jennings A, Quan H and Forster AJ. *A
    modification of the Elixhauser comorbidity measures into a point
    system for hospital death using administrative data*. Medical Care
    2009; 47(6):626-633.
  - Menendez ME, Neuhaus V, van Dijk CN, Ring D. *The Elixhauser
    comorbidity method outperforms the Charlson index in predicting
    inpatient death after orthopaedic surgery*. Clinical Orthopaedics
    and Related Research 2014; 472:2878–2886.
