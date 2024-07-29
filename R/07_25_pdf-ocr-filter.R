  # 精度の高い結果のみを抽出
  # 07_25_pdf-ocr-filter.R
word <- ocr_data |>  
  dplyr::filter(confidence > 75) |>
  `$`(_, "word") |> # $wordの取り出し
  paste0(collapse = "") # 文字列の結合

