  # HTMLの内容の取得
  # 15_15_scrape-selenider-get-page-source.R
html <- get_page_source(session)
rvest::html_table(html) |>
  `[[`(_, 1)
  ##

