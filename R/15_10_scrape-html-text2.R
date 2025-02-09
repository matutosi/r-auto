  # 文字列の取り出し(`html_text()とhtml_text2()の比較)`
  # 15_10_scrape-html-text2.R
html |> html_elements("p") |> html_text()
html |> html_elements("p") |> html_text2()

