  # 列の追加
  # 02_18_analysis-dplyr-mutate.R
  # idとperiodのデータ型を変換
dplyr::mutate(answer_joined, id = as.numeric(id), 
              years = as.numeric(years)) |> 
  print(n = 3)
  # 2列めの前にapという列を追加
answer_joined |>
  dplyr::mutate(id = as.numeric(id), years = as.numeric(years)) |> 
  dplyr::mutate(ap = stringr::str_sub(apps, 1, 2), .before = 2) |> 
  print(n = 3)

