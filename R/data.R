#' @title ICD-10 Codes, 2009 Version
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

#' @title ICD-10 Codes, 2011 Version
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
