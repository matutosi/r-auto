  # フォーム要素の取得
  # 15_36_scrape-books-form.R
url <- "https://www.morikita.co.jp/news/category/newbook"
form <- 
  url |>
  rvest::read_html() |>
  rvest::html_form() |>
  `[[`(_, 1)
form

