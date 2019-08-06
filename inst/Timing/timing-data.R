### Timing released version 0.4.1 vs #13 vs #13v2

# Packages
library(tidyverse)
library(devtools)

# Defining data-generating mechanisms
set.seed(20190806)
dgms <- tibble::tibble(
  n_ids = stats::runif(n = 100, min = 1000, max = 1000000) %>% ceiling()
)
dgms$n_codes <- stats::runif(n = nrow(dgms), min = 10, max = 50) %>% ceiling()
dgms$ss <- dgms$n_ids * dgms$n_codes
dgms <- dgms %>%
  dplyr::arrange(ss) %>%
  dplyr::mutate(i = row_number())
saveRDS(dgms, file = "/scratch/cvdanalysis/ag475/comorbidity-dgms.RDS")

# Simulate data
pb <- txtProgressBar(min = 0, max = nrow(dgms), style = 3)
for (i in dgms$i) {
  tmp <- data.frame(
    id = sample(1:dgms$n_ids[i], size = dgms$n_ids[i] * dgms$n_codes[i], replace = TRUE),
    code = comorbidity::sample_diag(dgms$n_ids[i] * dgms$n_codes[i]),
    stringsAsFactors = FALSE
  )
  saveRDS(tmp, file = paste0("/scratch/cvdanalysis/ag475/comorbidity-data/data-", i, ".RDS"))
  setTxtProgressBar(pb = pb, value = i)
}
close(pb)
rm(tmp, pb)
