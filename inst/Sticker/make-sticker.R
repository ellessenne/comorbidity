library(tidyverse)
library(hexSticker)
library(sysfonts)

sysfonts::font_add(family = "Sticker Font", regular = "lmmono10-italic.otf")
p_family <- "Sticker Font"

nf <- c(
  "inst/Sticker/comorbidity.png",
  "man/figures/hex.png"
)

for (w in nf) {
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
}
