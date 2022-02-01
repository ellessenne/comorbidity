### Timing released version (0.5.3) vs dev

# Install comorbidity
# remove.packages("comorbidity")
# install.packages("comorbidity")

# Packages
library(tidyverse)
library(devtools)
library(comorbidity)

# All
all <- readRDS("inst/Timing/comorbidity-dgms.RDS")

# Identify scenarios already done
done <- tibble::enframe(list.files(path = "inst/Timing/results/", pattern = "^res-released-")) %>%
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
  df <- readRDS(paste0("inst/Timing/data/data-", left$i[i], ".RDS"))
  tstart <- Sys.time()
  cmb <- comorbidity::comorbidity(x = df, id = "id", code = "code", score = "charlson", assign0 = FALSE)
  tend <- Sys.time()
  rm(df, cmb)
  gc()
  out <- difftime(tend, tstart, units = "secs")
  saveRDS(object = out, file = paste0("inst/Timing/results/res-released-", left$i[i], ".RDS"))
  rm(out)
}
