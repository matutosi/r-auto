  # 順次処理の関数
  # 02_52_analysis-purrr-reduce.R
answer |> 
  dplyr::summarise(apps = reduce(apps, paste_if_new), 
                   .by = c(area, satisfy)) |>
  print(n = 3)

