#' @keywords internal
.assign0 <- function(x, map) {
  if (grepl("charlson", map)) {
    # "Mild liver disease" (`mld`) and "Moderate/severe liver disease" (`msld`)
    x[msld == 1, mld := 0]
    # data.table version of
    # x$mld[x$msld == 1] <- 0
    # "Diabetes" (`diab`) and "Diabetes with complications" (`diabwc`)
    x[diabwc == 1, diab := 0]
    # x$diab[x$diabwc == 1] <- 0
    # "Cancer" (`canc`) and "Metastatic solid tumour" (`metacanc`)
    x[metacanc == 1, canc := 0]
    # x$canc[x$metacanc == 1] <- 0
  } else if (grepl("elixhauser", map)) {
    # "Hypertension, uncomplicated" (`hypunc`) and "Hypertension, complicated" (`hypc`)
    x[hypc == 1, hypunc := 0]
    # x$hypunc[x$hypc == 1] <- 0
    # "Diabetes, uncomplicated" (`diabunc`) and "Diabetes, complicated" (`diabc`)
    # x$diabunc[x$diabc == 1] <- 0
    x[diabc == 1, diabunc := 0]
    # "Solid tumour" (`solidtum`) and "Metastatic cancer" (`metacanc`)
    x[metacanc == 1, solidtum := 0]
    # x$solidtum[x$metacanc == 1] <- 0
  }
  return(x)
}
