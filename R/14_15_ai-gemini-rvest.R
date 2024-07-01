  # 作業用文章の準備
  # 14_15_ai-gemini-rvest.R
  # 寺田寅彦 学問の自由
url <- "https://www.aozora.gr.jp/cards/000042/files/43535_24583.html"
text <- 
  url |>
  rvest::read_html() |>
  rvest::html_elements(".main_text") |>
  rvest::html_text() |>
  stringr::str_remove_all("\\s+") # 空白文字を削除
stringr::str_sub(text, 1, 34)     # 1-34文字目の表示

