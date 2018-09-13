#' @keywords internal
.factorise <- function(x, score) {
  cols <- if (score == "charlson") {
    c("ami", "chf", "pvd", "cevd", "dementia", "copd", "rheumd", "pud", "mld", "diab", "diabwc", "hp", "rend", "canc", "msld", "metacanc", "aids")
  } else {
    c("chf", "carit", "valv", "pcd", "pvd", "hypunc", "hypc", "para", "ond", "cpd", "diabunc", "diabc", "hypothy", "rf", "ld", "pud", "aids", "lymph", "metacanc", "solidtum", "rheumd", "coag", "obes", "wloss", "fed", "blane", "dane", "alcohol", "drug", "psycho", "depre")
  }
  x[cols] <- lapply(x[cols], factor, levels = 0:1, labels = c("No", "Yes"))
  return(x)
}
