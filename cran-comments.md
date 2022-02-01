## Test environments

* local R installation, R 4.1.2, Intel-based macOS Big Sur 11.6.2
* ubuntu-latest (via GitHub Actions, devel, release, oldrel, 3.5, 3.4)
* windows-latest (via GitHub Actions, devel, release, oldrel, 3.5, 3.4)
* macos-latest (via GitHub Actions, release, oldrel)
* windows (via winbuilder, devel, release, oldrel)
* rhub (with rhub::check_for_cran())
* arm64 mac (via macbuilder)
* arm64 mac (via rhub::check(platform = 'macos-m1-bigsur-release'))

## R CMD check results

0 errors | 0 warnings | 0 note
