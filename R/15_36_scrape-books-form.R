  # フォーム要素の取得と設定
  # 15_36_scrape-books-form.R
url <- "https://www.morikita.co.jp/news/category/newbook"
form <- 
  url |>
  rvest::read_html() |>
  rvest::html_form() |> # フォームを2つ含む
  `[[`(_, 1) |>         # 1つ目のフォーム
form                    # フォームの内容を確認
search <- rvest::html_form_set(form, keywords = "テキストマイニング")
response <- rvest::html_form_submit(search)

