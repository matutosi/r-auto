  # CRANのパッケージを取得する関数
  # 15_22_scrape-scrape-cran-fun.R
scrape_cran_pkgs <- function(){
  url <- 
    "https://cran.r-project.org/web/packages/available_packages_by_name.html"
  html <- read_html(url)
  pkgs <-
    html |>
    html_table(header = TRUE) |>
    `[[`(_, 1) |> # [[1]]と同じ
    magrittr::set_colnames(c("pkg", "description")) |>
    dplyr::mutate(
      description = stringr::str_replace_all(description, "\n", " "))
  return(pkgs)
}
  # パッケージを検索する関数
  # 15_23_scrape-search-cran-pkgs-fun.R
search_cran_pkgs <- function(pkgs, pattern){
  pkgs <- 
    pkgs |>
      dplyr::filter(stringr::str_detect(pkg, pattern) |
                    stringr::str_detect(description, pattern)) |>
      `$`(_, "pkg")
  url <- "https://cran.r-project.org/web/packages/"
  urls <- paste0(url, pkgs)
  return(list(pkg = pkgs, url = urls))
}
  # 新刊情報のページ一覧を取得する関数
  # 15_26_scrape-monthly-urls-fun.R
get_monthly_urls <- function(){
  Sys.sleep(5)
  "https://www.morikita.co.jp/news/category/newbook" |>
    rvest::read_html() |>
    rvest::html_elements(".news_item") |> # "news_item"クラス
    rvest::html_elements("a") |>          # <a>タグ
    rvest::html_attr("href")              # hrefの属性値
}
  # 新刊紹介の個別ページを取得する関数
  # 15_28_scrape-books-urls-fun.R
get_new_book_urls <- function(url){
  Sys.sleep(5)
  url |> 
    rvest::read_html() |>
    rvest::html_elements("a.book_title.show_pc") |>
    rvest::html_attr("href") 
}
  # 個別ページの内容を取得する関数
  # 15_30_scrape-books-detail-urls-fun.R
get_book_html <- function(url){
  Sys.sleep(5)
  rvest::read_html(url)
}
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
  names(selectors) <-             # 名前を付ける
    c("title", "subtitle", "toc", "author", "price", "content", 
      "page", "isbn", "yyyymm")
  selectors |>
    purrr::map(\(x){ detail2elm_txt(details, x) }) |>
    tibble::as_tibble()
}
detail2elm_txt <- function(details, css){
  details |>
    rvest::html_elements(css) |>  # CSSセレクタ
    rvest::html_text2() |>        # 文字列のみ
    paste0(collapse = ", ")       # 複数著者への対応
}
  # 雨雲の動きの動画の取得
  # 15_44_scrape-jma-whole-game.R
scrape_jma <- function(url){
  session <- selenider::selenider_session(session = "chromote", timeout = 10)
  selenider::open_url(url)
  selenider::s("div.mdc-button__label") |> 
    selenider::elem_click()
  pngs <- list()
  n <- 13
  for(i in 1:n){
    no <- stringr::str_pad(i, width = 2, side = "left", pad = "0")
    png <- fs::path_temp(paste0(no, ".png"))
    pngs[[i]] <- selenider::take_screenshot(png)
    move_forward <- "/html/body/div[2]/div[1]/div[3]/div[1]/button[2]"
    if(i < n){
      selenider::s(xpath = move_forward) |> 
        selenider::elem_click()
    }
  }
  rain_gif <- fs::path_home("desktop/rain.gif")
  pngs |>
    unlist() |>
    magick::image_read() |>
    magick::image_animate(fps = 2) |>
    magick::image_write(rain_gif)
    # shell.exec(rain_gif)
  return(rain_gif)
}

