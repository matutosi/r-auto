  # 属性値の取り出し
  # 15_19_scrape-selenider-attr.R
ss("a") |>
  as.list() |>
  purrr::map_chr(elem_attr, "href")

