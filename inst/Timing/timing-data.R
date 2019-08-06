### Timing released version 0.2.0 vs 0.1.3

# Packages
library(tidyverse)
library(devtools)

# Defining data-generating mechanisms
set.seed(20190806)
dgms <- tidyr::crossing(
  n_ids = stats::runif(n = 100, min = 1000, max = 1000000) %>% ceiling(),
  n_codes = seq(from = 10, to = 50, by = 10)) %>% 
  dplyr::mutate(ss = n_ids * n_codes)

# Simulate data
pb <- txtProgressBar(min = 0, max = nrow(dgms), style = 3)
for (i in 1:nrow(dgms)) {
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