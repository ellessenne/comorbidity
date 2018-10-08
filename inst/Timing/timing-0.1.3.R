## Timing released version 0.2.0 vs 0.1.3

# Install comorbidity 0.1.3
devtools::install_github("ellessenne/comorbidity", ref = "0.1.3")

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

# Identify scenarios already done
done <- tibble::as.tibble(list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "^res-0.1.3-")) %>%
  dplyr::mutate(value = str_sub(value, 1, -5)) %>%
  tidyr::separate(value, into = c("x", "y", "i", "j"), sep = "-") %>%
  dplyr::select(-x, -y) %>%
  dplyr::mutate_all(as.numeric) %>%
  dplyr::arrange(i, j)

# Identify scenarios left to do
all <- tidyr::crossing(
  i = seq(nrow(dgms)),
  j = seq(reps)
)
left <- dplyr::anti_join(all, done, by = c("i", "j"))

# Shuffle so I could run multiple processes
left <- left[sample(x = 1:nrow(left), size = nrow(left), replace = FALSE), ]

# Time
for (i in seq(nrow(left))) {
  df <- readRDS(paste0("/scratch/cvdanalysis/ag475/comorbidity-data/data-", left$i[i], "-", left$j[i], ".RDS"))
  tstart <- Sys.time()
  cmb <- comorbidity::comorbidity(x = df, id = "id", code = "code", score = "charlson_icd10")
  tend <- Sys.time()
  rm(df, cmb)
  gc()
  out <- difftime(tend, tstart, units = "secs")
  saveRDS(object = out, file = paste0("/scratch/cvdanalysis/ag475/comorbidity-results/res-0.1.3-", left$i[i], "-", left$j[i], ".RDS"))
  rm(out)
}
