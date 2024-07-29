  # 位置特定用の画像の準備
  # 06_17_kybd-screenshot-needle-image.R
needle_image <- magick::image_read(sc) |>
                magick::image_crop(geometry = "60x60+0+0")
plot(needle_image)
path_needle <- fs::file_temp(ext = "png")
magick::image_write(needle_image, path_needle)

