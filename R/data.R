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
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://github.com/ellessenne/charlson/blob/master/data-raw/make_data.R).
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
#' @note The R code used to download and process the dataset from the CDC website is available [here](https://github.com/ellessenne/charlson/blob/master/data-raw/make_data.R).
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
#' @note The R code used to download and process the dataset from the CMS.gov website is available [here](https://github.com/ellessenne/charlson/blob/master/data-raw/make_data.R).
#'
#' @source CMS.gov Website: https://www.cms.gov/Medicare/Coding/ICD9ProviderDiagnosticCodes/codes.html
"icd9_2015"
