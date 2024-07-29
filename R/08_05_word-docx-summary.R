  # 概要の表示
  # 08_05_word-docx-summary.R
doc_1 |>
  docx_summary() |>
  tibble::as_tibble() |>
  head()

