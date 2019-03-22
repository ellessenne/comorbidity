# Test environments
* local macOS Mojave 10.14.3, R 3.5.3
* ubuntu (via travis-ci), R-oldrel, R-release, and R-devel
* windows (via appveyor)
* win-builder (R-oldrel, R-release, R-devel)

# R CMD check results on local macOS
0 errors | 0 warnings | 0 notes

# R CMD check results on win-builder (R-oldrel)
0 errors | 0 warnings | 2 notes
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Alessandro Gasparini <ag475@leicester.ac.uk>'
Possibly mis-spelled words in DESCRIPTION:
  Charlson (5:64, 6:4)
  Comorbidity (4:18)
  Elixhauser (6:63, 7:22)
  ICD (8:9, 8:21)
  Quan (8:35)
  comorbidity (5:24, 7:3)
* checking DESCRIPTION meta-information ... NOTE
Author field differs from that derived from Authors@R
  Author:    'Alessandro Gasparini [aut, cre] (<https://orcid.org/0000-0002-8319-7624>), Hojjat Salmasian [ctb] (ICD-9-CM scores)'
  Authors@R: 'Alessandro Gasparini [aut, cre] (0000-0002-8319-7624), Hojjat Salmasian [ctb] (ICD-9-CM scores)'

Both NOTEs seem to be spurious to me.

# R CMD check results on win-builder (R-release)
0 errors | 0 warnings | 0 notes

# R CMD check results on win-builder (R-devel)
0 errors | 0 warnings | 0 notes

# Reverse dependencies
There are no reverse dependencies