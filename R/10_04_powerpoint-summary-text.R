  # 文字列のデータのみ抽出
  # 10_04_powerpoint-summary-text.R
pptx_summary(pp) |>
  dplyr::filter(content_type == "paragraph") |>
  tibble::tibble() |>  print(n = 5)

