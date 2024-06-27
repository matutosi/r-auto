  # 文字列の取り出し
  # 15_18_scrape-selenider-text.R
s("#text_1") |>
  elem_text()
ss("option") |>
  as.list() |>
  purrr::map_chr(elem_text)

