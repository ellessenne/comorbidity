### Clean datasets to include in the package
# Required packages:
library(readxl)
library(stringr)
library(devtools)
library(usethis)
library(haven)

########################################################################################################################
### Dataset #1: ICD-10 codes, 2009 version
# Download dataset
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10/allvalid2009(detailed%20titles%20headings).xls", destfile = "data-raw/allvalid2009.xls")

# Read data in Excel format
icd10_2009 <- readxl::read_excel(
  "data-raw/allvalid2009.xls",
  skip = 7,
  col_names = c("Status", "Code", "ICD.title")
)

# Remove lines where code contains the character "-", i.e. headers:
icd10_2009[grepl("-", icd10_2009[["Code"]]), ]
icd10_2009 <- icd10_2009[!grepl("-", icd10_2009[["Code"]]), ]

# Produce a "Code.clean" variable with no punctuation
icd10_2009[["Code.clean"]] <- stringr::str_replace_all(string = icd10_2009[["Code"]], pattern = "[^[:alnum:]]", replacement = "")

# Re-order the columns
icd10_2009 <- icd10_2009[, c(2, 4, 3, 1)]

# Convert all character columns to ASCII format
icd10_2009[["Code"]] <- iconv(icd10_2009[["Code"]], from = "UTF-8", to = "ASCII")
icd10_2009[["Code.clean"]] <- iconv(icd10_2009[["Code.clean"]], from = "UTF-8", to = "ASCII")
icd10_2009[["ICD.title"]] <- iconv(icd10_2009[["ICD.title"]], from = "UTF-8", to = "ASCII")
icd10_2009[["Status"]] <- iconv(icd10_2009[["Status"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10_2009, overwrite = TRUE)

########################################################################################################################
### Dataset #2: ICD-10 codes, 2011 version
# Download dataset
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10/allvalid2011 (detailed%20titles%20headings).xls", destfile = "data-raw/allvalid2011.xls")

# Read data in Excel format
icd10_2011 <- readxl::read_excel(
  "data-raw/allvalid2011.xls",
  skip = 7,
  col_names = c("Status", "Code", "ICD.title")
)

# Remove lines where code contains the character "-", i.e. headers:
icd10_2011[grepl("-", icd10_2011[["Code"]]), ]
icd10_2011 <- icd10_2011[!grepl("-", icd10_2011[["Code"]]), ]

# Produce a "Code.clean" variable with no punctuation
icd10_2011[["Code.clean"]] <- stringr::str_replace_all(string = icd10_2011[["Code"]], pattern = "[^[:alnum:]]", replacement = "")

# Re-order the columns
icd10_2011 <- icd10_2011[, c(2, 4, 3, 1)]

# Convert all character columns to ASCII format
icd10_2011[["Code"]] <- iconv(icd10_2011[["Code"]], from = "UTF-8", to = "ASCII")
icd10_2011[["Code.clean"]] <- iconv(icd10_2011[["Code.clean"]], from = "UTF-8", to = "ASCII")
icd10_2011[["ICD.title"]] <- iconv(icd10_2011[["ICD.title"]], from = "UTF-8", to = "ASCII")
icd10_2011[["Status"]] <- iconv(icd10_2011[["Status"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10_2011, overwrite = TRUE)

########################################################################################################################
### Dataset #3: ICD-9 codes, 2015 version
# Download dataset
download.file(url = "https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/Downloads/ICD-9-CM-v32-master-descriptions.zip", destfile = "data-raw/ICD-9-CM-v32-master-descriptions.zip")

# Unzip files
unzip("data-raw/ICD-9-CM-v32-master-descriptions.zip", exdir = "data-raw")

# Read ICD-9 diagnostic codes
icd9_2015 <- readxl::read_excel("data-raw/CMS32_DESC_LONG_SHORT_DX.xlsx", skip = 1, col_names = c("Code", "Long_description", "Short_description"))

# Convert all character columns to ASCII format
icd9_2015[["Code"]] <- iconv(icd9_2015[["Code"]], from = "UTF-8", to = "ASCII")
icd9_2015[["Long_description"]] <- iconv(icd9_2015[["Long_description"]], from = "UTF-8", to = "ASCII")
icd9_2015[["Short_description"]] <- iconv(icd9_2015[["Short_description"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd9_2015, overwrite = TRUE)

########################################################################################################################
### Dataset #4 ICD-10-CM codes, 2018 version
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2018/2018-ICD-10-CM-Codes-File.zip", destfile = "data-raw/2018-ICD-10-CM-Codes-File.zip")

# Unzip files
unzip("data-raw/2018-ICD-10-CM-Codes-File.zip", exdir = "data-raw")

# Read files
icd10cm_2018 <- readr::read_tsv(file = "data-raw/icd10cm_codes_2018.txt", col_names = FALSE)
icd10cm_2018[["Code"]] <- substr(icd10cm_2018[[1]], 1, 7)
icd10cm_2018[["Description"]] <- substr(icd10cm_2018[[1]], 9, 400)
icd10cm_2018[[1]] <- NULL

# Convert all character columns to ASCII format
icd10cm_2018[["Code"]] <- iconv(icd10cm_2018[["Code"]], from = "UTF-8", to = "ASCII")
icd10cm_2018[["Description"]] <- iconv(icd10cm_2018[["Description"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10cm_2018, overwrite = TRUE)

########################################################################################################################
### Dataset #5 ICD-10-CM codes, 2017 version
download.file(url = "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/ICD10CM/2017/icd10cm_codes_2017.txt", destfile = "data-raw/icd10cm_codes_2017.txt")

# Read files
icd10cm_2017 <- readr::read_tsv(file = "data-raw/icd10cm_codes_2017.txt", col_names = FALSE)
icd10cm_2017[["Code"]] <- substr(icd10cm_2017[[1]], 1, 7)
icd10cm_2017[["Description"]] <- substr(icd10cm_2017[[1]], 9, 400)
icd10cm_2017[[1]] <- NULL

# Convert all character columns to ASCII format
icd10cm_2017[["Code"]] <- iconv(icd10cm_2017[["Code"]], from = "UTF-8", to = "ASCII")
icd10cm_2017[["Description"]] <- iconv(icd10cm_2017[["Description"]], from = "UTF-8", to = "ASCII")

# Save data in R format
usethis::use_data(icd10cm_2017, overwrite = TRUE)

########################################################################################################################
### Dataset #6: Adult same-day discharges, 2010 (from Stata)
nhds2010 <- haven::read_dta("https://www.stata-press.com/data/r17/nhds2010.dta")
nhds2010 <- haven::zap_formats(nhds2010)
nhds2010 <- haven::zap_label(nhds2010)
nhds2010 <- haven::zap_labels(nhds2010)

# Save data in R format
usethis::use_data(nhds2010, overwrite = TRUE)

########################################################################################################################
### Dataset #7: Australian mortality data, 2010 (from Stata)
australia10 <- haven::read_dta("https://www.stata-press.com/data/r17/australia10.dta")
australia10 <- haven::zap_formats(australia10)
australia10 <- haven::zap_label(australia10)
australia10 <- haven::zap_labels(australia10)

# Save data in R format
usethis::use_data(australia10, overwrite = TRUE)

########################################################################################################################
### Remove unnecessary files
lf <- list.files(path = "data-raw", full.names = TRUE, pattern = ".xls|.txt|.zip|.pdf")
invisible(file.remove(lf))
