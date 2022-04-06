#' @title ICD-10 Diagnostic Codes, 2009 Version
#'
#' @description A dataset containing the 2009 version of the ICD-10 codes.
#'
#' @format A data frame with 10,817 rows and 4 variables:
#' \describe{
#'   \item{Code}{ICD-10 diagnostic code}
#'   \item{Code.clean}{ICD-10 diagnostic code, removing all punctuation}
#'   \item{ICD.title}{Code description, in plain English.}
#'   \item{Status}{Additional information, if available.}
#' }
#'
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
#'
#' @source CDC Website: https://goo.gl/6e2mvb
"icd10_2009"

#' @title ICD-10 Diagnostic Codes, 2011 Version
#'
#' @description A dataset containing the 2011 version of the ICD-10 codes.
#'
#' @format A data frame with 10,856 rows and 4 variables:
#' \describe{
#'   \item{Code}{ICD-10 diagnostic code}
#'   \item{Code.clean}{ICD-10 diagnostic code, removing all punctuation}
#'   \item{ICD.title}{Code description, in plain English.}
#'   \item{Status}{Additional information, if available.}
#' }
#'
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
#'
#' @source CDC Website: https://goo.gl/rcTJJ2
"icd10_2011"

#' @title ICD-9 Diagnostic Codes, 2015 Version (v32)
#'
#' @description A dataset containing the version of the ICD-9 codes effective October 1, 2014.
#'
#' @format A data frame with 14,567 rows and 3 variables:
#' \describe{
#'   \item{Code}{ICD-9 diagnostic code}
#'   \item{Long_description}{Long description of each code}
#'   \item{Short_description}{Short description of each code}
#' }
#'
#' @note The R code used to download and process the dataset from the CMS.gov website is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
#'
#' @source CMS.gov Website: https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes.html
"icd9_2015"

#' @title ICD-10-CM Diagnostic Codes, 2022 Version
#'
#' @description A dataset containing the 2022 version of the ICD10-CM coding system.
#'
#' @format A data frame with 72,750 rows and 2 variables:
#' \describe{
#'   \item{Code}{ICD-10-CM diagnostic code}
#'   \item{Description}{Description of each code}
#' }
#'
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
"icd10cm_2022"

#' @title ICD-10-CM Diagnostic Codes, 2018 Version
#'
#' @description A dataset containing the 2018 version of the ICD10-CM coding system.
#'
#' @format A data frame with 71,704 rows and 2 variables:
#' \describe{
#'   \item{Code}{ICD-10-CM diagnostic code}
#'   \item{Description}{Description of each code}
#' }
#'
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
"icd10cm_2018"

#' @title ICD-10-CM Diagnostic Codes, 2017 Version
#'
#' @description A dataset containing the 2017 version of the ICD10-CM coding system.
#'
#' @format A data frame with 71,486 rows and 2 variables:
#' \describe{
#'   \item{Code}{ICD-10-CM diagnostic code}
#'   \item{Description}{Description of each code}
#' }
#'
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
"icd10cm_2017"

#' @title Adult same-day discharges, 2010
#'
#' @description A dataset containing adult same-day discharges from 2010, obtained from Stata 17.
#'
#' @format A data frame with 2,210 rows and 15 variables:
#' \describe{
#'   \item{ageu}{Units for age}
#'   \item{age}{Age}
#'   \item{sex}{Sex}
#'   \item{race}{Race}
#'   \item{month}{Discharge month}
#'   \item{status}{Discharge status}
#'   \item{region}{Region}
#'   \item{atype}{Type of admission}
#'   \item{dx1}{Diagnosis 1, ICD9-CM}
#'   \item{dx2}{Diagnosis 2, ICD9-CM}
#'   \item{dx3}{Diagnosis 3, ICD9-CM, imported incorrectly}
#'   \item{dx3corr}{Diagnosis 3, ICD9-CM, corrected}
#'   \item{pr1}{Procedure 1}
#'   \item{wgt}{Frequency weight}
#'   \item{recid}{Order of record (raw data)}
#' }
#'
#' @note The R code used to download and process the dataset from Stata is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
"nhds2010"

#' @title Australian mortality data, 2010
#'
#' @description A dataset containing Australian mortality data, obtained from Stata 17.
#'
#' @format A data frame with 3,322 rows and 3 variables:
#' \describe{
#'   \item{cause}{ICD-10 code representing cause of death}
#'   \item{sex}{Gender}
#'   \item{deaths}{Number of deaths}
#' }
#'
#' @note The R code used to download and process the dataset from Stata is available [here](https://raw.githubusercontent.com/ellessenne/comorbidity/master/data-raw/make-data.R).
"australia10"
