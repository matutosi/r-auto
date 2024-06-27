  # 新刊紹介の個別ページを取得する関数
  # 15_28_scrape-book-urls-fun.R
get_new_book_urls <- function(url){
  Sys.sleep(5)
  url |> 
    rvest::read_html() |>
    rvest::html_elements("a.book_title.show_pc") |>
    rvest::html_attr("href") 
}

