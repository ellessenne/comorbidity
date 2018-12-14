library(tidyverse)
library(ggridges)
library(hexSticker)
# Using dev version of hexSticker from:
# devtools::install_github("GuangchuangYu/hexSticker")
library(sysfonts)

sysfonts::font_add(family = "Iosevka CC Slab Medium Italic", regular = "iosevka-cc-slab-mediumitalic.ttf")
p_family <- "Iosevka CC Slab Medium Italic"

sticker(
  subplot = "inst/Sticker/coding-blue-stretched.png",
  s_x = 1,
  s_y = 1,
  s_width = 0.53,
  s_height = 0.53,
  package = "",
#  p_x = 1,
#  p_y = 0.5,
#  p_color = "#583576",
#  p_family = p_family,
#  p_size = 7,
  h_size = 2.5,
  h_fill = "white",
  h_color = "#E24A85",
  url = "comorbidity",
  u_x = 1,
  u_y = 0.15,
  u_color = "#4197CF",
  u_family = p_family,
  u_size = 3.5,
  filename = "inst/Sticker/comorbidity.png",
  dpi = 1200
)

sticker(
  subplot = "inst/Sticker/coding-blue-stretched.png",
  s_x = 1,
  s_y = 1,
  s_width = 0.53,
  s_height = 0.53,
  package = "",
  #  p_x = 1,
  #  p_y = 0.5,
  #  p_color = "#583576",
  #  p_family = p_family,
  #  p_size = 7,
  h_size = 2.5,
  h_fill = "white",
  h_color = "#E24A85",
  url = "comorbidity",
  u_x = 1,
  u_y = 0.15,
  u_color = "#4197CF",
  u_family = p_family,
  u_size = 3.5,
  filename = "man/figures/hex.png",
  dpi = 1200
)
