library(tidyverse)
library(ggridges)
library(formattable)

### Results
res.0.1.3 <- lapply(
  list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "res-0.1.3-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      value = w
    ) %>%
      dplyr::mutate(value = str_sub(value, 49, -5)) %>%
      tidyr::separate(value, into = c("x", "y", "i", "j"), sep = "-") %>%
      dplyr::select(-x, -y) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i, j) %>%
      dplyr::mutate(v = "0.1.3")
  }
)
res.0.1.3 <- dplyr::bind_rows(res.0.1.3)

res.0.2.0 <- lapply(
  list.files(path = "/scratch/cvdanalysis/ag475/comorbidity-results/", pattern = "res-0.2.0-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      value = w
    ) %>%
      dplyr::mutate(value = str_sub(value, 49, -5)) %>%
      tidyr::separate(value, into = c("x", "y", "i", "j"), sep = "-") %>%
      dplyr::select(-x, -y) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i, j) %>%
      dplyr::mutate(v = "0.2.0")
  }
)
res.0.2.0 <- dplyr::bind_rows(res.0.2.0)

### DGMs
dgms <- tidyr::crossing(
  n = c(100, 1000, 5000, 10000, 50000, 100000, 500000, 1000000),
  nc = c(1000, 10000, 100000, 1000000, 5000000, 10000000)
) %>%
  dplyr::filter(nc > n) %>%
  dplyr::arrange(n, nc) %>%
  dplyr::mutate(i = row_number())

### Plot
res <- dplyr::bind_rows(
  res.0.1.3,
  res.0.2.0
) %>%
  tidyr::spread(
    value = time,
    key = v
  ) %>%
  mutate(ratio = `0.2.0` / `0.1.3`) %>%
  left_join(dgms, "i") %>%
  mutate(
    n = factor(paste(formattable::comma(n, 0)), levels = c("100", "1,000", "5,000", "10,000", "50,000", "100,000", "500,000", "1,000,000")),
    nc = factor(paste(formattable::comma(nc, 0)), levels = c("1,000", "10,000", "100,000", "1,000,000", "5,000,000", "10,000,000"))
  )

ggplot2::ggplot(res, aes(x = ratio, y = nc, color = n, fill = n)) +
  ggridges::geom_density_ridges(alpha = 0.25) +
  ggridges::theme_ridges() +
  ggplot2::scale_fill_brewer(palette = "Set1") +
  ggplot2::scale_colour_brewer(palette = "Set1") +
  ggplot2::scale_x_continuous(labels = scales::percent) +
  labs(x = "Ratio of time - v0.2.0 vs v0.1.3", y = "# ICD Codes", colour = "# Individuals", fill = "# Individuals") +
  theme(legend.position = "top")
ggsave(filename = "inst/Timing/plot.png", dpi = 300, width = 6.5, height = 6.5)
