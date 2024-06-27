  # 見出しを除く本文の取り出し
  # 08_09_word-docx-summary-filter-normal.R
doc_1 |>
  docx_summary() |>
  tibble::as_tibble() |>
  dplyr::filter(style_name == "Normal") |>
  dplyr::select(content_type, style_name, text) |>
  dplyr::filter(text != "")

