library(tidyverse)

### Results
res.release <- lapply(
  list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "res-released-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      value = w
    ) %>%
      dplyr::mutate(value = str_sub(value, 49, -5)) %>%
      tidyr::separate(value, into = c("x", "y", "i"), sep = "-") %>%
      dplyr::select(-x, -y) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i) %>%
      dplyr::mutate(v = "released")
  }
)
res.release <- dplyr::bind_rows(res.release)

res.13 <- lapply(
  list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "res-13-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      value = w
    ) %>%
      dplyr::mutate(value = str_sub(value, 49, -5)) %>%
      tidyr::separate(value, into = c("x", "y", "i"), sep = "-") %>%
      dplyr::select(-x, -y) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i) %>%
      dplyr::mutate(v = "13")
  }
)
res.13 <- dplyr::bind_rows(res.13)

res.13v2 <- lapply(
  list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "res-13v2-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      value = w
    ) %>%
      dplyr::mutate(value = str_sub(value, 49, -5)) %>%
      tidyr::separate(value, into = c("x", "y", "i"), sep = "-") %>%
      dplyr::select(-x, -y) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i) %>%
      dplyr::mutate(v = "13v2")
  }
)
res.13v2 <- dplyr::bind_rows(res.13v2)

### DGMs
dgms <- readRDS("/scratch/cvdanalysis/ag475/comorbidity-dgms.RDS")

### Plot
res <- dplyr::bind_rows(
  res.release,
  res.13,
  res.13v2
) %>%
  tidyr::spread(
    value = time,
    key = v
  ) %>%
  mutate(
    ratio.13 = released / `13`,
    ratio.13v2 = released / `13v2`
  ) %>%
  left_join(dgms, "i")

ggplot(res, aes(x = n_ids, size = n_codes, y = ratio.13v2)) +
  geom_point(alpha = 0.5) +
  theme_minimal(base_family = "PT Sans Narrow") +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scales::comma) +
  theme(legend.position = "top") +
  labs(x = "Number of individuals", y = "Fold improvement in computational speed", size = "Codes per individual", color = "", fill = "")

ggsave(filename = "inst/Timing/plot.png", dpi = 300, width = 5, height = 5)
