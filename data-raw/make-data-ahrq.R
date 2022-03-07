### Clean datasets to include in the package
# Required packages:
library(readxl)
library(stringr)
library(devtools)
library(usethis)
library(haven)

########################################################################################################################
### Internal Dataset #1: List of regex patterns
# Empty list
lofregex <- list()

# Get Elixhauser icd10cm_2020_1 and add to lofregex (see sourced file below for details)
source('AHRQ-Elixhauser/sas-parse/icd10cm_2020_1/get_lofregex.R')

lofregex[["elixhauser_ahrq_2020"]] <- list()
lofregex[["elixhauser_ahrq_2020"]][["icd10"]] <- icd10cm_2020_1_lofregex

########################################################################################################################
### Internal Dataset #2: List of msdrg mappings

# Mappings retrieved by parsing SAS code, see file sourced below
source('AHRQ-Elixhauser/sas-parse/icd10cm_2020_1/get_lofmsdrg.R')

########################################################################################################################
### Internal Dataset #3: Get icd10cm_2021_1 icd mappings
# Creates a list Elixhauser2021Formats with the following objects: 
# ElixhauserAHRQ2021Map, ElixhauserAHRQ2021Abbr, ElixhauserAHRQ2021Labels
source('AHRQ-Elixhauser/sas-parse/icd10cm_2021_1/get_mappings.R')

########################################################################################################################
### Internal Dataset #4: Get icd10cm_2022_1 icd mappings
# Creates a list Elixhauser2022Formats with the following objects: 
# ElixhauserAHRQ2022Map, ElixhauserAHRQ2022Abbr, ElixhauserAHRQ2022Labels
source('AHRQ-Elixhauser/sas-parse/icd10cm_2022_1/get_mappings.R')

########################################################################################################################
