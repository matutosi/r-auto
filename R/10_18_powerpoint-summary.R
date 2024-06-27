  # パワーポイントの概要表示
  # 10_18_powerpoint-summary.R
library(officer)
  # path <- fs::path_package("officer", "doc_examples/example.pptx")
  # pp <- read_pptx(path)
pp |>
  pptx_summary() |>
  tibble::tibble()

