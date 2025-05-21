  # 間隔を空けた結合
  # 11_18_image-append-border.R
imgs[1:2] |>
  image_border(color = gray(0.8), geometry = "30") |>
  image_append() |>
  plot()

