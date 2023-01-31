
<!-- README.md is generated from README.Rmd. Please edit that file -->

# This is a fork of the {comorbidity} package.

There have been a limited number of people who have used this fork in
their own work since I first created it back in 2020. If anyone finds
that their code that utlized the `Main` branch of this fork no longer
functions, please see the `retired` branch. For those who have been using
the `updated_elixhauser` branch, you may continue to do so. The `Main`
branch currently reflects `updated_elixhauser`, but may be changed
substantiatlly in the future as I attempt to prepare this fork for
possible merging with ellessenne’s version.

# The {comorbidity} Package: Computing Comorbidity Scores <img src="man/figures/hex.png" width = "150" align="right" />

Last updated: 2023-01-31

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

In addition, this package provides features implementing the 2020, 2021
and 2022 versions of the AHRQ’s ‘Elixhauser Comorbidity Software’
(<https://www.hcup-us.ahrq.gov/toolssoftware/comorbidityicd10/comorbidity_icd10.jsp>)
in R. Simialar to the AHRQ Software, the two following Elixhauser
Comorbidity Indices refined for ICD-10-CM could be predicted:

- Risk of in-hospital mortality
- Risk of 30-day, all-cause readmission

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

## Sample Data of ICD-10 codes, ICD-10 codes squences, MS-DRG, and Present on Admission (POA) status of ICD-10 codes

This data set could be used to test the package specifically the AHRQ
Software oriented features. The data fields of the data set are:

- DischargeFiscalYearNBR (Year of Discharge)
- QuarterNBR (Year Quarter)
- MSDRG (MS-DRG)
- ICD10DiagnosisCD (ICD-10 Code)
- ICD10DiagnosisSEQ (Sequence of ICD-10 Code)
- PresentOnAdmissionCD (POA)

``` r
x10 <- as.data.frame(
  readRDS(file.path('data', 'ahrq_section_test_data.rds'))
)
print(
  x10[x10$ID %in% 1:3, ]
)
##    ID DischargeFiscalYearNBR QuarterNBR MSDRG ICD10DiagnosisCD ICD10DiagnosisSEQ
## 1   1                   2022          4   267          T82857A                 1
## 2   1                   2022          4   267           K91871                 2
## 3   1                   2022          4   267             I350                 3
## 4   1                   2022          4   267            I2510                 4
## 5   1                   2022          4   267             E785                 5
## 6   1                   2022          4   267              I10                 6
## 7   1                   2022          4   267             Z006                 7
## 8   1                   2022          4   267             E039                 8
## 9   1                   2022          4   267           Z20828                 9
## 10  1                   2022          4   267             Z951                10
## 11  1                   2022          4   267             I480                11
## 12  1                   2022          4   267          T82818A                12
## 13  1                   2022          4   267            Z7982                13
## 14  1                   2022          4   267           Z87891                14
## 15  1                   2022          4   267             Y838                15
## 16  2                   2022          4   707              C61                 1
## 17  2                   2022          4   707             N179                 2
## 18  2                   2022          4   707           F17213                 3
## 19  2                   2022          4   707             E871                 4
## 20  2                   2022          4   707             K567                 5
## 21  2                   2022          4   707             K219                 6
## 22  2                   2022          4   707              I10                 7
## 23  2                   2022          4   707            G4733                 8
## 24  2                   2022          4   707             M109                 9
## 25  2                   2022          4   707           Z20828                10
## 26  2                   2022          4   707             K648                11
## 27  2                   2022          4   707             R110                12
## 28  2                   2022          4   707             Z886                13
## 29  3                   2022          4   655             C678                 1
## 30  3                   2022          4   655            G8929                 2
## 31  3                   2022          4   655             I714                 3
## 32  3                   2022          4   655             N400                 4
## 33  3                   2022          4   655             M545                 5
## 34  3                   2022          4   655              I10                 6
## 35  3                   2022          4   655           Z96652                 7
## 36  3                   2022          4   655            M4800                 8
## 37  3                   2022          4   655           Z20828                 9
## 38  3                   2022          4   655           Z79891                10
## 39  3                   2022          4   655           Z87891                11
##    PresentOnAdmissionCD
## 1                     Y
## 2                     N
## 3                     Y
## 4                     Y
## 5                     Y
## 6                     Y
## 7                     E
## 8                     Y
## 9                     Y
## 10                    E
## 11                    Y
## 12                    Y
## 13                    E
## 14                    E
## 15                    Y
## 16                    Y
## 17                    Y
## 18                    Y
## 19                    Y
## 20                    N
## 21                    Y
## 22                    Y
## 23                    Y
## 24                    Y
## 25                    Y
## 26                    Y
## 27                    N
## 28                    E
## 29                    Y
## 30                    Y
## 31                    Y
## 32                    Y
## 33                    Y
## 34                    Y
## 35                    Y
## 36                    Y
## 37                    Y
## 38                    E
## 39                    E
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
##   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
## 1  1   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    1
## 2  2   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    0
## 3  3   0   0   0    0        0    0      0   0   0    0      0  0    0    0    0        0    0
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
##   id ami chf pvd cevd dementia copd rheumd pud mld diab diabwc hp rend canc msld metacanc aids
## 1  1   0   0   1    0        0    0      0   0   0    0      0  0    0    1    0        0    0
## 2  2   0   0   0    1        0    0      0   0   0    0      0  0    0    0    0        0    0
## 3  3   0   0   0    0        0    0      0   1   0    0      0  0    0    0    0        0    0
## 4  4   0   0   1    1        0    0      0   0   0    0      0  0    0    1    0        0    0
## 5  5   0   0   0    0        0    0      0   0   0    0      0  0    0    1    0        0    0
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

Comorbidity codes for different versions of the AHRQ’s ‘Elixhauser
Comorbidity Software’ could be computed. Accordingly, ‘map’ argument
could take any of the following ones:

- elixhauser_ahrq_2020
- elixhauser_ahrq_2021
- elixhauser_ahrq_2022

The following example calculates the comorbidity codes for the 2020
version.

``` r
elixhauser_ahrq_2020 <- comorbidity(
  x=x10[x10$ID %in% 1:3, ],
  id='ID',
  code='ICD10DiagnosisCD',
  map='elixhauser_ahrq_2020',
  assign0=F,
  drg='MSDRG',
  icd_rank='ICD10DiagnosisSEQ',
  poa='PresentOnAdmissionCD',
  year='DischargeFiscalYearNBR',
  quarter='QuarterNBR'
)
?comorbidity
elixhauser_ahrq_2020
##   ID CHF VALVE PULMCIRC PERIVASC PARA NEURO CHRNLUNG DM DMCX HYPOTHY RENLFAIL LIVER ULCER AIDS
## 1  1   0     0        0        0    0     0        0  0    0       1        0     0     0    0
## 2  2   0     0        0        0    0     0        0  0    0       0        0     0     0    0
## 3  3   0     0        0        1    0     0        0  0    0       0        0     0     0    0
##   LYMPH METS TUMOR ARTH COAG OBESE WGHTLOSS LYTES BLDLOSS ANEMDEF ALCOHOL DRUG PSYCH DEPRESS HTN_C
## 1     0    0     0    0    0     0        0     0       0       0       0    0     0       0     1
## 2     0    0     0    0    0     0        0     1       0       0       0    0     0       0     1
## 3     0    0     0    0    0     0        0     0       0       0       0    0     0       0     1
```

The following example calculates the comorbidity codes for the 2022
version. The 2021 and 2022 versions do not require a specified “drg”
argument.

``` r
elixhauser_ahrq_2022 <- comorbidity(
  x=x10[x10$ID %in% 1:3, ],
  id='ID',
  code='ICD10DiagnosisCD',
  map='elixhauser_ahrq_2022',
  assign0=F,
  icd_rank='ICD10DiagnosisSEQ',
  poa='PresentOnAdmissionCD',
  year='DischargeFiscalYearNBR',
  quarter='QuarterNBR'
)

elixhauser_ahrq_2022
##   ID AIDS ALCOHOL ANEMDEF AUTOIMMUNE BLDLOSS CANCER_LEUK CANCER_LYMPH CANCER_METS CANCER_NSITU
## 1  1    0       0       0          0       0           0            0           0            0
## 2  2    0       0       0          0       0           0            0           0            0
## 3  3    0       0       0          0       0           0            0           0            0
##   CANCER_SOLID CBVD COAG DEMENTIA DEPRESS DIAB_CX DIAB_UNCX DRUG_ABUSE HF HTN_CX HTN_UNCX LIVER_MLD
## 1            0    0    0        0       0       0         0          0  0      0        1         0
## 2            0    0    0        0       0       0         0          0  0      0        1         0
## 3            0    0    0        0       0       0         0          0  0      0        1         0
##   LIVER_SEV LUNG_CHRONIC NEURO_MOVT NEURO_OTH NEURO_SEIZ OBESE PARALYSIS PERIVASC PSYCHOSES
## 1         0            0          0         0          0     0         0        0         0
## 2         0            0          0         0          0     0         0        0         0
## 3         0            0          0         0          0     0         0        1         0
##   PULMCIRC RENLFL_MOD RENLFL_SEV THYROID_HYPO THYROID_OTH ULCER_PEPTIC VALVE WGHTLOSS
## 1        0          0          0            1           0            0     1        0
## 2        0          0          0            0           0            0     0        0
## 3        0          0          0            0           0            0     0        0
```

Scores:

``` r
unw_eci <- score(elixhauser9, weights = NULL, assign0 = FALSE)
vw_eci <- score(elixhauser9, weights = "vw", assign0 = FALSE)
all.equal(unw_eci, vw_eci)
## [1] "Attributes: < Length mismatch: comparison on first 1 components >"
## [2] "Mean relative difference: 2"
```

To calculate ‘Risk of in-hospital mortality’ index, ‘weights’ is set to
‘mw’.

``` r
ahrq_scores <- score(elixhauser_ahrq_2022, weights = "mw", assign0 = FALSE)
ahrq_scores
## [1] -3  0  3
## attr(,"map")
## [1] "elixhauser_ahrq_2022"
```

‘Risk of 30-day, all-cause readmission’ index could be calculated by
setting ‘weights’ to ‘rw’.

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
vignette("01-introduction", package = "comorbidity")
vignette("02-comorbidity-scores", package = "comorbidity")
```

## Copyright

The icon for the hex sticker was made by
[monkik](https://www.flaticon.com/authors/monkik) from
[www.flaticon.com](https://www.flaticon.com), and is licensed by
[Creative Commons BY 3.0](https://creativecommons.org/licenses/by/3.0).
