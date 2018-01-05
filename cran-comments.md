This is a resubmission.

I added references for the scores in the "Description" field of the DESCRIPTION file, including the PubMed ID as no DOI was provided. 

# Test environments
* local macOS (High Sierra) install, R 3.4.3
* ubuntu (via travis-ci), R-oldrel, R-release, and R-devel
* windows (via appveyor)
* win-builder

# R CMD check results on local macOS
0 errors | 0 warnings | 0 notes

# Reverse dependencies
There are no reverse dependencies

# NOTE on win-builder
* checking CRAN incoming feasibility ... NOTE
  Possibly mis-spelled words in DESCRIPTION:
    Charlson (5:64, 5:80)
    Comorbidity (4:18)
    Elixhauser (6:2, 6:32)
    ICD (6:70)
    PMID (5:95, 6:49, 6:95)
    Quan (6:84)
    comorbidity (5:24, 6:13)
  
The words above are ok.