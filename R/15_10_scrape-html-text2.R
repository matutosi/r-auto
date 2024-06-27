  # 文字列の取り出し(ブラウザ的な表示)
  # 15_10_scrape-html-text2.R
html |>
  html_elements("p") |>
  html_text()
html |>
  html_elements("p") |>
  html_text2()

