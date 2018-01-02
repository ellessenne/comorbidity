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
* Added a `NEWS.md` file to track changes to the package.
* Added CI with Travis and AppVeyor
* Added automated testing with `testthat`
* Added code coverage with Codecov
