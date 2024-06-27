  # 余白の除去
  # 11_26_image-trim.R
img_06_07 <- c(filled_06, imgs[7])
trimed <- image_trim(img_06_07)
c(img_06_07, trimed) |>
  image_border(gray(0.7), "10x10") |> 
  image_append() |> 
  plot()

