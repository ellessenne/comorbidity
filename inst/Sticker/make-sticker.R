library(cropcircles)
library(magick)
library(tidyverse)
library(ggpath)
library(ragg)
library(glue)
library(svglite)

x <- image_read("inst/Sticker/hex.png")
xhex <- hex_crop(x)
hex <- ggplot() +
  geom_from_path(aes(0.5, 0.5, path = xhex)) +
  xlim(0, 1) +
  ylim(0, 1) +
  theme_void() +
  coord_fixed()
hex

# .png versions
nf <- c(
  "inst/Sticker/comorbidity.png",
  "man/figures/hex.png"
)
for (this in nf) {
  ggsave(filename = this, plot = hex, height = 5, width = 5, dpi = 300, device = agg_png)
}
