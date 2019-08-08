### Timing released version 0.4.1 vs #13 vs #13v2

# Install comorbidity
install.packages("comorbidity")

# Packages
library(tidyverse)
library(devtools)

# All
all <- readRDS("/scratch/cvdanalysis/ag475/comorbidity-dgms.RDS")

# Identify scenarios already done
done <- tibble::enframe(list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "^res-released-")) %>%
  dplyr::mutate(value = str_sub(value, 1, -5)) %>%
  tidyr::separate(value, into = c("x", "y", "i"), sep = "-") %>%
  dplyr::select(-x, -y) %>%
  dplyr::mutate_all(as.numeric) %>%
  dplyr::arrange(i)

# Identify scenarios left to do
left <- dplyr::anti_join(all, done, by = "i")

# Shuffle so I could run multiple processes
left <- left[sample(x = 1:nrow(left), size = nrow(left), replace = FALSE), ]

# Time
for (i in seq(nrow(left))) {
  df <- readRDS(paste0("/scratch/cvdanalysis/ag475/comorbidity-data/data-", left$i[i], ".RDS"))
  tstart <- Sys.time()
  cmb <- comorbidity::comorbidity(x = df, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  tend <- Sys.time()
  rm(df, cmb)
  gc()
  out <- difftime(tend, tstart, units = "secs")
  saveRDS(object = out, file = paste0("/scratch/cvdanalysis/ag475/comorbidity-results/res-released-", left$i[i], ".RDS"))
  rm(out)
}
