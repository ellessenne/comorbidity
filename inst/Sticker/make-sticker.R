# library(cropcircles)
# library(magick)
# library(tidyverse)
# library(ggpath)
# library(ragg)
# library(glue)
# library(svglite)
#
# x <- image_read("inst/Sticker/this.png")
# xhex <- hex_crop(x)
# hex <- ggplot() +
#   geom_from_path(aes(0.5, 0.5, path = xhex)) +
#   xlim(0, 1) +
#   ylim(0, 1) +
#   theme_void() +
#   coord_fixed()
# hex
#
# # .png versions
# dpi <- c(300, 600, 1200)
# for (this in dpi) {
#   ggsave(filename = glue("inst/Sticker/comorbidity-v2-{this}.png"), plot = hex, height = 5, width = 5, dpi = this, device = agg_png)
# }

library(tidyverse)
library(hexSticker)
library(sysfonts)
library(usethis)

sysfonts::font_add(family = "Sticker Font", regular = "lmmono10-italic.otf")
p_family <- "Sticker Font"

nf <- c(
  "inst/Sticker/comorbidity.png",
  "man/figures/hex.png"
)

for (w in nf) {
  ui_info("Doing {w}...")
  print(
    sticker(
      subplot = "inst/Sticker/coding-blue-stretched.png",
      s_x = 1,
      s_y = 1,
      s_width = 0.55,
      s_height = 0.55,
      package = "",
      #  p_x = 1,
      #  p_y = 0.5,
      #  p_color = "#583576",
      #  p_family = p_family,
      #  p_size = 7,
      h_size = 1,
      h_fill = "white",
      h_color = "#6496CD",
      url = "comorbidity",
      u_x = 1,
      u_y = 0.15,
      u_color = "#C54B82",
      u_family = p_family,
      u_size = 48,
      filename = w,
      dpi = 1200
    )
  )
  ui_done("Done!")
}
