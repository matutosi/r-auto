  # 列の追加
  # 02_24_analysis-dplyr-mutate.R
dplyr::mutate(answer, id = as.numeric(id), period = as.numeric(period)) |> 
  print(n = 3)
answer |>
  dplyr::mutate(ap = stringr::str_sub(apps, 1, 2), .before = 2) |> # 2列目の前
  dplyr::mutate(co = stringr::str_sub(comment, 1, 2), .after = ap) |>
  print(n = 3)

