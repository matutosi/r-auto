  # 見出しを含む本文の取り出し
  # 08_06_word-docx-summary-filter-paragraph.R
doc_1 |>
  docx_summary() |>
  tibble::as_tibble() |>
  dplyr::filter(content_type == "paragraph") |>
  dplyr::select(content_type, style_name, text) |>
  dplyr::filter(text != "") |>
  print(n = 5)

