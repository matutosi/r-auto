  # 順次処理の関数
  # 02_53_analysis-purrr-reduce.R
answer_mutated |> 
  dplyr::summarise(apps = reduce(apps, paste_if_new), 
                   .by = c(area, satisfy)) |>
  print(n = 3)

