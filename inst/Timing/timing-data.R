### Timing released version (0.5.3) vs dev

# Packages
library(tidyverse)
library(devtools)

# Defining data-generating mechanisms
set.seed(20211019)
dgms <- tibble::tibble(
  n_ids = stats::runif(n = 200, min = 1000, max = 1000000) %>% ceiling()
)
dgms$n_codes <- stats::runif(n = nrow(dgms), min = 5, max = 15) %>% ceiling()
dgms$ss <- dgms$n_ids * dgms$n_codes
dgms <- dgms %>%
  dplyr::arrange(ss) %>%
  dplyr::mutate(i = row_number())
saveRDS(dgms, file = "inst/Timing/comorbidity-dgms.RDS")

# Simulate data
pb <- txtProgressBar(min = 0, max = nrow(dgms), style = 3)
for (i in dgms$i) {
  tmp <- tibble(
    id = sample(1:dgms$n_ids[i], size = dgms$n_ids[i] * dgms$n_codes[i], replace = TRUE),
    code = comorbidity::sample_diag(dgms$n_ids[i] * dgms$n_codes[i])
  )
  saveRDS(tmp, file = paste0("inst/Timing/data/data-", i, ".RDS"))
  setTxtProgressBar(pb = pb, value = i)
}
close(pb)
rm(tmp, pb)
