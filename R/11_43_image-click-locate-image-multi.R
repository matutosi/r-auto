  # 複数画像の同一位置での切り取り
  # 11_43_image-click-locate-image-multi.R
geometry <- ltrb2geo(pos[[1]], pos[[2]])
croped_multi <- 
  imgs[25:27] |>
  image_scale("1200") |>
  as.list() |>
  purrr::map(image_crop, geometry) |>
  image_join()
croped_multi
croped_multi |>
  image_border("white", "10") |>
  image_append() |>
  plot()

