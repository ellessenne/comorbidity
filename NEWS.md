# comorbidity 1.0.2

* The `copd` and `ami` comorbidities for the Charlson index have been renamed to `cpd` and `mi`, respectively (#53, thanks @DrYan1102). Please be aware that this might break some old code if you were selecting comorbidities by name.

* New dataset: ICD10-CM, 2022 version, named `icd10cm_2022`.

# comorbidity 1.0.1

* The startup message pointing out changes in the API now appears less often (40% probability).

* Fixed a bug that was causing all comorbidities to be assigned a value of one when there was missing data in the `code` column (#50), thanks @Chris-M-P for reporting this.

# comorbidity 1.0.0

* `comorbidity` version 1.0.0 is a release that substantially modifies and updates the package API.
  There are a lot of improvements in terms of performance, supported algorithms, and user-facing functions; see e.g. [this thread on GitHub](https://github.com/ellessenne/comorbidity/pull/38).
  Specific user-facing changes, including examples of the new API, are discussed in more detail here: https://ellessenne.github.io/comorbidity/articles/C-changes.html

* If required, you can revert to the previous release by installing from GitHub: `remotes::install_github("ellessenne/comorbidity@0.5.3")`.

* A startup message pointing out the changes in the API is now displayed with a 50% probability when attaching the package and will be removed in future releases.

* New contributors: [Sing Yi Chia](https://github.com/SY-CHIA) and [Edmund Teo](https://github.com/torema-ed).

# comorbidity 0.5.3

* `comorbidity` now accepts `data.table` objects as input (#23);

* `comorbidity` can deal with non-syntactically valid names (#25);

* Fixed coding typo in vignette (#10, #26);

* Reduced number of random tests, as R CMD check was taking too long on some platforms getting killed on CRAN (as reported by Kurt Hornik).

# comorbidity 0.5.2

* Fixed another bug introduced by the switch to `data.table` that only occurred when the input dataset had extra columns other than `id` and `code`.

# comorbidity 0.5.1

* The `melt` generic in `data.table` has been deprecated; the dependency on `reshape2` has now been removed;

* Fixed bugs introduced by switching to `data.table` in `comorbidity` 0.5.0: column names `id` and `code` were expecting these specific names, now fixed and behaves as expected.

# comorbidity 0.5.0

* `comorbidity` is now 10+ times faster, thanks to [Jonathan Williman](https://github.com/jwilliman) contributing code based on the `data.table` package;

* Fixed typo in vignette regarding weighting algorithm for the AHRQ Elixhauser comorbidity score (#14, thanks to @cornflakegrl);

* Added `pkgdown` website: https://ellessenne.github.io/comorbidity.

# comorbidity 0.4.1

* Fixed bug in regex patterns (#10, thanks to @francisco003 for reporting it and @salmasian for the pull request).

# comorbidity 0.4.0

### BREAKING CHANGES

Modified the behaviour of the `assign0` argument after further discussion with [Anders Alexandersson](https://github.com/aalexandersson) in Issue #9: now there is no default, forcing the user to decide whether to apply a hierarchy of comorbidity codes or not. This will make the algorithm more transparent to the end user, allowing an informed choice. See `?comorbidity::comorbidity` and `vignette("comorbidityscores", package = "comorbidity")` for further details on the hierarchy being applied.

# comorbidity 0.3.0

### BREAKING CHANGES

`comorbidity` now returns two Elixhauser scores, one computed using the algorithm of van Walraven _et al_. (2009) and a second one computed using the AHRQ algorithm (Moore _et al_., 2017). Thanks to Yumiko Abe-Jones for feedback and the discussion regarding weighted Elixhauser scores.

More information can be found on the package vignette: `vignette("comorbidityscores", package = "comorbidity")`.

# comorbidity 0.2.1

* Fixed bug in weighting algorithm of Elixhauser comorbidity score;
* The `assign0` argument of `comorbidity` now defaults to `FALSE`;
* Improved documentation for the `comorbidity` function:
    - `assign0` now explains in details what hierarchy of comorbidities is applied;
    - added reference to package vignette where comorbidity scores and weighting algorithms are explained in more detail.

# comorbidity 0.2.0

* `comorbidity` is faster, with a conservative estimated speed-up of >60%;
* Lots of internal housekeeping;
* Fixed broken GitHub links to the R script used to generate the datasets bundled with `comorbidity`.

### BREAKING CHANGES

The `score` argument from `comorbidity` has been split into `score` and `icd`. For instance, the command `comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10")` has to be modified as `r comorbidity(x = x, id = "id", code = "code", score = "charlson", icd = "icd10")`. The default value of `icd` is `icd10`, for ICD-10 codes, and possible values are `icd10` and `icd9`.

# comorbidity 0.1.3

* Added `nhds2010` and `australia10` datasets, imported from Stata version 15.

Bug fix:
* Fixed a bug in the regex for the ICD10 Charlson score;
* Fixed a bug in the regex for the ICD10 Elixhauser score.

# comorbidity 0.1.2

* Added ICD10-CM data (version 2017 and 2018).

# comorbidity 0.1.1

* Documented variables that were missing among those returned by `comorbidity()` (@corinne-riddell, #5);
* Added CITATION file: `citation("comorbidity")` now returns a properly formatted entry.

# comorbidity 0.1.0

* Added support for the ICD-9-CM version of Charlson and Elixhauser scores
* Added vignette with information on the scores computed by `comorbidity`
* `sample_diag_icd10()` function renamed back to `sample_diag()`, as now can simulate ICD-9-CM codes too

# comorbidity 0.0.3

* Added datasets `icd10_2009` and `icd10_2011` with ICD-10 codes, 2009 and 2011 versions (respectively)
* `sample_diag` is now `sample_diag_icd10` and simulates proper ICD-10 codes
* Added Elixhauser comorbidity score
* Renamed the package to `comorbidity` as it now can compute more than just the Charlson score
* Added formal testing: codes for the Charlson score are properly identified
* Added formal testing: codes for the Elixhauser score are properly identified

# charlson 0.0.2

* Running computations in parallel now should work on every platform
* Improved code coverage
* `charlson` is marginally faster

# charlson 0.0.1

* Rebooted `charlson` using only base R functions
* Added a `NEWS.md` file to track changes to the package
* Added CI with Travis and AppVeyor
* Added automated testing with `testthat`
* Added code coverage with Codecov
