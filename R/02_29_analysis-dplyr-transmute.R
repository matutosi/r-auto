  # 列の追加と選択
  # 02_29_analysis-dplyr-transmute.R
dplyr::transmute(sales, item = stringr::str_sub(item, 1, 2), count) |> head(5)

