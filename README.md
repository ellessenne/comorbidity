
<!-- README.md is generated from README.Rmd. Please edit that file -->

# charlson

[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ellessenne/charlson?branch=master&svg=true)](https://ci.appveyor.com/project/ellessenne/charlson)
[![Travis-CI Build
Status](https://travis-ci.org/ellessenne/charlson.svg?branch=master)](https://travis-ci.org/ellessenne/charlson)
[![Coverage
Status](https://img.shields.io/codecov/c/github/ellessenne/charlson/master.svg)](https://codecov.io/github/ellessenne/charlson?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/charlson)](https://cran.r-project.org/package=charlson)

`charlson` is an R package for computing the Charlson comorbidity index
using ICD-10 codes.

## Installation

You can install charlson from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("ellessenne/charlson")
```

## Example

This is a basic example which shows you how to solve a common problem.

First, we simulate 150 pseudo-ICD-10 diagnostic codes for 10 individuals
using the `sample_codes()` function:

``` r
# load charlson
library(charlson)
# set a seed for reproducibility
set.seed(1)
x <- data.frame(
  id = sample(1:10, size = 150, replace = TRUE),
  code = sample_diag(150),
  stringsAsFactors = FALSE)
head(x)
#>   id code
#> 1  3 P696
#> 2  4 O044
#> 3  6 I437
#> 4 10 L417
#> 5  3  N35
#> 6  9 E965
```

Then, we compute the Charlson score, index, and each comorbidity domain:

``` r
cs = charlson(x = x, id = "id", code = "code")
head(cs)
#>   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend
#> 1  1   0   0   0    0        0    0      0   0   0    0      0  0    0
#> 2  2   0   0   0    0        0    0      0   0   0    0      0  0    0
#> 3  3   0   0   0    1        0    0      0   0   0    0      0  0    0
#> 4  4   0   0   0    0        0    1      0   0   0    0      0  0    0
#> 5  5   0   0   0    1        0    1      0   0   0    0      0  0    0
#> 6  6   0   1   0    0        0    0      0   0   0    0      0  0    0
#>   canc msld metacanc aids score index
#> 1    0    0        0    0     0     0
#> 2    1    0        0    0     2    2+
#> 3    1    0        0    0     3    2+
#> 4    0    0        0    0     1     1
#> 5    1    0        0    0     4    2+
#> 6    0    0        0    0     1     1
```

## References

The Charlson comorbidity index computed with this package follows the
ICD-10 definition of Quan H, Sundararajan V, Halfon P, Fong A, Burnand
B, Luthi JC, et al., *Coding algorithms for definingcComorbidities in
ICD-9-CM and ICD-10 administrative data*. Medical Care 2005;
43:1130-1139.
