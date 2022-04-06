#' @keywords internal
.matchit <- function(x, id, code, regex) {
  ### Deal with missing codes
  mvb <- id
  backup <- x[, ..mvb]
  backup <- unique(backup)
  x <- stats::na.omit(x)
  # If there are no rows left (= user passed missing data only), then error:
  if (nrow(x) == 0) stop("No non-missing data, please check your input data", call. = FALSE)

  ### Get list of unique codes used in dataset that match comorbidities
  ..cd <- unique(x[[code]])
  loc <- sapply(X = regex, FUN = function(p) stringi::stri_subset_regex(str = ..cd, pattern = p))
  loc <- utils::stack(loc)
  data.table::setDT(loc)
  data.table::setnames(x = loc, new = c(code, "ind"))

  ### Merge list with original data.table (data.frame)
  x <- merge(x, loc, all.x = TRUE, allow.cartesian = TRUE, by = code)
  x[, (code) := NULL]
  x <- unique(x)

  ### Spread wide
  mv <- c(id, "ind")
  xin <- x[, ..mv]
  xin[, value := 1L]
  x <- data.table::dcast.data.table(xin, stats::as.formula(paste(id, "~ ind")), fill = 0)
  if (!is.null(x[["NA"]])) x[, `NA` := NULL]

  ### Restore IDs
  x <- merge(x, backup, by = id, all.y = TRUE, )
  data.table::setnafill(x = x, type = "const", fill = 0L)

  ### Add missing columns
  for (col in names(regex)) {
    if (is.null(x[[col]])) x[, (col) := 0L]
  }
  data.table::setcolorder(x, c(id, names(regex)))

  ### Return
  return(x)
}
