# ### Compute Charlson score and Charlson index
# if (score == "charlson") {
#   x$score <- with(x, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0 != "none", 0, 1) + diab * ifelse(diabwc == 1 & assign0 != "none", 0, 1) + diabwc + hp + rend + canc * ifelse(metacanc == 1 & assign0 != "none", 0, 1) + msld + metacanc + aids)
#   x$index <- with(x, cut(score, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
#   x$wscore <- with(x, ami + chf + pvd + cevd + dementia + copd + rheumd + pud + mld * ifelse(msld == 1 & assign0 != "none", 0, 1) + diab * ifelse(diabwc == 1 & assign0 != "none", 0, 1) + diabwc * 2 + hp * 2 + rend * 2 + canc * ifelse(metacanc == 1 & assign0 != "none", 0, 2) + msld * 3 + metacanc * 6 + aids * 6)
#   x$windex <- with(x, cut(wscore, breaks = c(0, 1, 2.5, 4.5, Inf), labels = c("0", "1-2", "3-4", ">=5"), right = FALSE))
# } else {
#   x$score <- with(x, chf + carit + valv + pcd + pvd + hypunc * ifelse(hypc == 1 & assign0 != "none", 0, 1) + hypc + para + ond + cpd + diabunc * ifelse(diabc == 1 & assign0 != "none", 0, 1) + diabc + hypothy + rf + ld + pud + aids + lymph + metacanc + solidtum * ifelse(metacanc == 1 & assign0 != "none", 0, 1) + rheumd + coag + obes + wloss + fed + blane + dane + alcohol + drug + psycho + depre)
#   x$index <- with(x, cut(score, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
#   x$wscore_ahrq <- with(x, chf * 9 + carit * 0 + valv * 0 + pcd * 6 + pvd * 3 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * (-1) + para * 5 + ond * 5 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0 != "none", 0, 0) + diabc * (-3) + hypothy * 0 + rf * 6 + ld * 4 + pud * 0 + aids * 0 + lymph * 6 + metacanc * 14 + solidtum * ifelse(metacanc == 1 & assign0 != "none", 0, 7) + rheumd * 0 + coag * 11 + obes * (-5) + wloss * 9 + fed * 11 + blane * (-3) + dane * (-2) + alcohol * (-1) + drug * (-7) + psycho * (-5) + depre * (-5))
#   x$wscore_vw <- with(x, chf * 7 + carit * 5 + valv * (-1) + pcd * 4 + pvd * 2 + ifelse(hypunc == 1 | hypc == 1, 1, 0) * 0 + para * 7 + ond * 6 + cpd * 3 + diabunc * ifelse(diabc == 1 & assign0 != "none", 0, 0) + diabc * 0 + hypothy * 0 + rf * 5 + ld * 11 + pud * 0 + aids * 0 + lymph * 9 + metacanc * 12 + solidtum * ifelse(metacanc == 1 & assign0 != "none", 0, 4) + rheumd * 0 + coag * 3 + obes * (-4) + wloss * 6 + fed * 5 + blane * (-2) + dane * (-2) + alcohol * 0 + drug * (-7) + psycho * 0 + depre * (-3))
#   x$windex_ahrq <- with(x, cut(wscore_ahrq, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
#   x$windex_vw <- with(x, cut(wscore_vw, breaks = c(-Inf, 0, 1, 4.5, Inf), labels = c("<0", "0", "1-4", ">=5"), right = FALSE))
# }
#
# ### If 'assign0 = "both"', then apply hierarchy to individual comorbidity domains too
# if (assign0 == "both") {
#   if (score == "charlson") {
#     # "Mild liver disease" (`mld`) and "Moderate/severe liver disease" (`msld`)
#     x$mld[x$msld == 1] <- 0
#     # "Diabetes" (`diab`) and "Diabetes with complications" (`diabwc`)
#     x$diab[x$diabwc == 1] <- 0
#     # "Cancer" (`canc`) and "Metastatic solid tumour" (`metacanc`)
#     x$canc[x$metacanc == 1] <- 0
#   } else {
#     # "Hypertension, uncomplicated" (`hypunc`) and "Hypertension, complicated" (`hypc`)
#     x$hypunc[x$hypc == 1] <- 0
#     # "Diabetes, uncomplicated" (`diabunc`) and "Diabetes, complicated" (`diabc`)
#     x$diabunc[x$diabc == 1] <- 0
#     # "Solid tumour" (`solidtum`) and "Metastatic cancer" (`metacanc`)
#     x$solidtum[x$metacanc == 1] <- 0
#   }
# }
# }
#' @export
score <- function(x, weights = NULL, assign0) {
  ### First, check the function is getting a 'comorbidity' data.frame
  if (!inherits(x = x, what = "comorbidity")) {
    stop("This function can only be used on an object of class 'comorbidity', which you can obtain by using the 'comorbidity()' function. See ?comorbidity for more details.", call. = FALSE)
  }
  ### Identify scoring algorithm
  map <- attr(x, "map")
  ### Check arguments
  arg_checks <- checkmate::makeAssertCollection()
  # check class of 'x' again, better safe then sorry
  checkmate::assert_class(x, classes = "comorbidity", add = arg_checks)
  # weights must be a single string value
  checkmate::assert_string(weights, null.ok = TRUE, add = arg_checks)
  # weights must be one of the supported; case insensitive
  if (!is.null(weights)) {
    weights <- tolower(weights)
  }
  # check that weighting system is appropriate for the used scoring algorithm
  if (grepl("charlson", map)) {
    checkmate::assert_choice(weights, choices = c("charlson", "quan_2011"), null.ok = TRUE, add = arg_checks)
  } else if (grepl("elixhauser", map)) {
    checkmate::assert_choice(weights, choices = c("vw", "ahrq", "swiss"), null.ok = TRUE, add = arg_checks)
  }
  # assign0 be a single boolean value
  checkmate::assert_logical(assign0, add = arg_checks)
  # Report if there are any errors
  if (!arg_checks$isEmpty()) checkmate::reportAssertions(arg_checks)

  # If weights = NULL, then do non-weighted scores
  if (is.null(weights)) {
    ww <- rep(1, length(.maps[[map]]))
    names(ww) <- names(.maps[[map]])
  } else {
    ww <- .weights[[weights]]
  }
  ww <- matrix(data = ww, ncol = 1)

  # Calculate score using matrix multiplication
  score <- as.matrix(x[, names(.maps[[map]])]) %*% ww
  score <- drop(score)
  attr(score, "map") <- map
  attr(score, "weights") <- weights

  # Return score
  return(score)
}
