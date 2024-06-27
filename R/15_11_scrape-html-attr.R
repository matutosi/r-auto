  # 属性値の取り出し
  # 15_11_scrape-html-attr.R
html |>
  html_elements("a") |>
  html_attr("href")
html |>
  html_elements("img") |>
  html_attr("src")

