  # 個別ページの内容を取得する関数
  # 15_30_scrape-books-detail-urls-fun.R
get_book_html <- function(url){
  Sys.sleep(5)
  rvest::read_html(url)
}

