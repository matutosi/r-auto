  # 列の追加
  # 02_18_analysis-dplyr-mutate.R
dplyr::mutate(answer, id = as.numeric(id), period = as.numeric(period)) |> 
  print(n = 3)
answer |>
  dplyr::mutate(id = as.numeric(id), period = as.numeric(period)) |> 
  dplyr::mutate(ap = stringr::str_sub(apps, 1, 2), .before = 2) |> # 2列目の前
  print(n = 3)

