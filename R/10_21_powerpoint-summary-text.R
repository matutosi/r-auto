  # 文字列のデータ
  # 10_21_powerpoint-summary-text.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "paragraph") |>
  tibble::tibble()

