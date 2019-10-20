# Test environments
* local macOS Mojave 10.14.6, R 3.6.1
* ubuntu (via travis-ci), R-oldrel, R-release, and R-devel
* windows (via appveyor)
* win-builder (R-oldrel, R-release, R-devel)
* r-hub (using rhub::check_for_cran())

# R CMD check results on local macOS
0 errors | 0 warnings | 0 notes

# R CMD check results on win-builder (R-oldrel, R-release, R-devel)
0 errors | 0 warnings | 1 note

# R CMD check results on r-hub (using rhub::check_for_cran())
0 errors | 0 warnings | 1 note

# Reverse dependencies
There are no reverse dependencies

# NOTE on various platforms:
  * checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Alessandro Gasparini <alessandro.gasparini@ki.se>’

  Days since last update: 4  

I apologise for submitting an update so soon after the previous one, but some changes in one of the dependencies (data.table) lead to a quite serious bug that was not caught while testing the previous release.
