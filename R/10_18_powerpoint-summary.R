  # パワーポイントの概要表示
  # 10_18_powerpoint-summary.R
library(officer)
pptx_summary(pp) |> 
  tibble::tibble() |>
  print(n = 5)

