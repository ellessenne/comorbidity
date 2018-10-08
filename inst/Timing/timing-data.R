### Timing released version 0.2.0 vs 0.1.3

# Packages
library(tidyverse)
library(devtools)

# Number of replicates
reps <- 100

# Defining data-generating mechanisms
dgms <- tidyr::crossing(
  n = c(100, 1000, 5000, 10000, 50000, 100000, 500000, 1000000),
  nc = c(1000, 10000, 100000, 1000000, 5000000, 10000000)
) %>%
  dplyr::filter(nc > n) %>%
  dplyr::arrange(n, nc)

# Random seed
set.seed(960653427)

# Simulate data
pb <- txtProgressBar(min = 0, max = reps * nrow(dgms), style = 3)
for (i in 1:nrow(dgms)) {
  for (j in 1:reps) {
    tmp <- data.frame(
      id = sample(1:dgms$n[i], size = dgms$nc[i], replace = TRUE),
      code = comorbidity::sample_diag(dgms$nc[i]),
      stringsAsFactors = FALSE
    )
    saveRDS(tmp, file = paste0("/scratch/cvdanalysis/ag475/comorbidity-data/data-", i, "-", j, ".RDS"))
    setTxtProgressBar(pb = pb, value = (i - 1) * reps + j)
  }
}
close(pb)
rm(tmp, pb)
