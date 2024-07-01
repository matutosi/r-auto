  # 間隔を開けた結合
  # 11_21_image-append-border.R
imgs[1:3] |>
  image_border(color = gray(0.8), geometry = "30") |>
  image_append() |>
  plot()

