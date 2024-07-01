  # 画像の2値化
  # 11_34_image-binarization.R
img_bin <- 
  path |>
  image_read() |>
  image_convert(colorspace = "Gray") |>
  image.binarization::image_binarization(type = "wolf")
plot(img_bin)

