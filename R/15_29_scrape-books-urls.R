  # 新刊紹介の個別ページの取得
  # 15_29_scrape-books-urls.R
new_book_urls <- 
  monthly_urls[1:2] |> # 全ての月のときは不要
  purrr::map(get_new_book_urls) |>
  unlist()
new_book_urls

