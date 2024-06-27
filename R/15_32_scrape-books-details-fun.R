  # 新刊の詳細情報を取得する関数
  # 15_32_scrape-books-details-fun.R
detail2df <- function(details){
  selectors <-  # 取得する要素のCSSセレクタ
    c(".book_titles_wrapper > .book_title", 
      ".book_subtitle", ".index", ".author", 
      ".price.js-bookPage-bookPrice", ".content", 
         # 以下は，CSSセレクタをコピーしたもの
      ".book_data.js-bookDataHeight > div:nth-child(1) > span.data",
      ".book_data.js-bookDataHeight > div:nth-child(3) > span.data", 
      ".book_data.js-bookDataHeight > div:nth-child(4) > span.data")
  names(selectors) <- # 名前を付けて
    c("title", "subtitle", "toc", "author", "price", "content", 
      "page", "isbn", "yyyymm")
  selectors |>
    purrr::map(~detail2elm_txt(details, .)) |>
    tibble::as_tibble()
}
detail2elm_txt <- function(details, css){
  details |>
    rvest::html_elements(css) |>   # CSSセレクタ
    rvest::html_text2() |>         # 文字列のみ
    paste0(collapse = ", ") # 複数著者などの対応
}

