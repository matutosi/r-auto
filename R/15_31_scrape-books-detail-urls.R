  # 個別ページの内容の取得
  # 15_31_scrape-books-detail-urls.R
bk_details <- purrr::map(new_book_urls, get_book_html)
bk_details[[1]]

