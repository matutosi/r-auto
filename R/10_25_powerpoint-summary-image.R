  # 画像データの一覧の取り出し
  # 10_25_powerpoint-summary-image.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "image") |>
  `$`(_, "media_file") |> 
  head()

