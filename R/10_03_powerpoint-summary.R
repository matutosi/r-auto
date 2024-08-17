  # パワーポイントの概要表示
  # 10_03_powerpoint-summary.R
pptx_summary(pp) |> 
  tibble::tibble() |>
  print(n = 5)

