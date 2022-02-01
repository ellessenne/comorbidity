library(tidyverse)
library(hrbrthemes)

### Results
res.release <- lapply(
  list.files(path = "inst/Timing/results/", pattern = "res-released-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      i = w
    ) %>%
      dplyr::mutate(i = str_sub(i, 35, -5)) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i) %>%
      dplyr::mutate(v = "released")
  }
)
res.release <- dplyr::bind_rows(res.release)

res.dev <- lapply(
  list.files(path = "inst/Timing/results/", pattern = "res-dev-", full.names = TRUE),
  function(w) {
    tibble::tibble(
      time = readRDS(w),
      i = w
    ) %>%
      dplyr::mutate(i = str_sub(i, 30, -5)) %>%
      dplyr::mutate_all(as.numeric) %>%
      dplyr::arrange(i) %>%
      dplyr::mutate(v = "dev")
  }
)
res.dev <- dplyr::bind_rows(res.dev)

### DGMs
dgms <- readRDS("inst/Timing/comorbidity-dgms.RDS")

### Plot
res <- dplyr::bind_rows(
  res.release,
  res.dev
) %>%
  tidyr::spread(
    value = time,
    key = v
  ) %>%
  mutate(ratio = released / dev) %>%
  left_join(dgms, "i")

ggplot(res, aes(x = n_ids, size = n_codes, y = ratio)) +
  geom_point(alpha = 0.5) +
  geom_smooth(show.legend = FALSE, color = "red", size = 1) +
  theme_ipsum_rc(base_size = 12) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scales::comma) +
  theme(legend.position = "top") +
  labs(x = "Number of subjects", y = "Fold improvement in computational speed", size = "Codes per subject", color = "", fill = "")
ggsave(filename = "inst/Timing/plot.png", dpi = 600, width = 4.5, height = 4.5, device = ragg::agg_png, res = 600, units = "in")
