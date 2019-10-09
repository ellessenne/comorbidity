#' @title Computing Comorbidity Scores
#'
#' @description Computing comorbidity scores such as the weighted Charlson score
#' (Charlson, 1987 \doi{10.1016/0021-9681(87)90171-8}) and the Elixhauser
#' comorbidity score (Elixhauser, 1998 \doi{10.1097/00005650-199801000-00004})
#' using ICD-9-CM or ICD-10 codes (Quan, 2005 \doi{10.1097/01.mlr.0000182534.19832.83}).
#'
#' @name comorbidity-package
#' @docType package
#' @author Alessandro Gasparini (alessandro.gasparini@@ki.se)
NULL

#' @keywords internal
.datatable.aware <- TRUE

# Quiets concerns of R CMD check re: variable names used internally
if (getRversion() >= "2.15.1") utils::globalVariables(c(".", "L1", ":=", "value"))
