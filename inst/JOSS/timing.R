library(tidyverse)
library(comorbidity)
library(microbenchmark)

# Define scenarios
scenarios <- tidyr::crossing(
  n = 10 ^ (1:5),
  nc = 10 ^ (2:6)
) %>%
  filter(nc >= n)

# Function for timing purposes
fun <- function(n, nc, parallel = FALSE) {
  x <- data.frame(
    id = sample(1:n, size = nc, replace = TRUE),
    code = sample_diag(nc),
    stringsAsFactors = FALSE
  )
  comorbidity(x = x, id = "id", code = "code", score = "charlson_icd10", parallel = parallel)
}

# Set seed for reproducibility
set.seed(287358454)

# Time stuff
pb <- txtProgressBar(min = 1, max = nrow(scenarios), style = 3)
results <- lapply(1:nrow(scenarios), function(i) {
  out <- microbenchmark(
    "serial" = fun(n = scenarios$n[i], nc = scenarios$nc[i], parallel = FALSE),
    "parallel" = fun(n = scenarios$n[i], nc = scenarios$nc[i], parallel = TRUE),
    times = 10
  )
  out$n <- scenarios$n[i]
  out$nc <- scenarios$nc[i]
  setTxtProgressBar(pb, i)
  out
})
close(pb)

# Make plot
plot <- results %>%
  bind_rows() %>%
  group_by(n, nc, expr) %>%
  mutate(i = row_number()) %>%
  ungroup() %>%
  spread(key = expr, value = time) %>%
  mutate(ratio = serial / parallel) %>%
  group_by(n, nc) %>%
  summarise(
    y_mean = mean(ratio),
    y_median = median(ratio),
    y_min = min(ratio),
    y_max = max(ratio)
  ) %>%
  ungroup() %>%
  mutate(n = factor(as.character(scales::comma(n)), levels = as.character(scales::comma(10 ^ (1:5))))) %>%
  ggplot(aes(x = nc, y = y_mean, ymin = y_min, ymax = y_max, group = n, colour = n)) +
  geom_hline(yintercept = 1, colour = "grey", linetype = "dashed") +
  geom_line(position = position_dodge(width = 1 / 5)) +
  geom_point(position = position_dodge(width = 1 / 5)) +
  geom_errorbar(position = position_dodge(width = 1 / 5), width = 1 / 5) +
  scale_x_log10(breaks = 10 ^ (2:6), labels = scales::comma) +
  ggthemes::scale_color_colorblind() +
  labs(y = "Ratio of time (sequential vs parallel)", x = "# of diagnostic codes", color = "# of individuals") +
  theme_bw() +
  theme(legend.position = c(0, 1), legend.justification = c(0, 1), legend.background = element_blank(), legend.key = element_blank())
plot

# Save plot
ggsave(plot, filename = "plot.png", dpi = 600, width = 6, height = 4)
