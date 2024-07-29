  # 余白の除去
  # 11_21_image-trim.R
trimed <- image_trim(imgs[7])
c(imgs[7], trimed) |>
  image_border(gray(0.7), "10x10") |> 
  image_append() |> 
  plot()

