  # パワーポイントの概要表示
  # 10_19_powerpoint-summary.R
library(officer)
pp |>
  pptx_summary() |>
  tibble::tibble()

