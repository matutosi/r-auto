  # politeパッケージのインストールと呼び出し
  # 15_01_scrape-bow-install.R
install.packages("polite")
library(polite)

  # スクレイピングの許可状況の確認
  # 15_02_scrape-bow.R
bow("https://cran.r-project.org/web/packages/")

  # rvestとseleniderのインストール
  # 15_03_eval.R
install.packages("rvest")
install.packages("selenider")

  # chromoteとshowimageのインストール
  # 15_04_scrape-selenider-chromote.R
install.packages("chromote")
install.packages("showimage")

  # HTMLの内容の読み込み
  # 15_05_scrape-read-html.R
url <- "https://matutosi.github.io/r-auto/data/sample.html"
html <- read_html(url)
html

  # タグでの要素の取得
  # 15_06_scrape-html-element-tag.R
h1 <- html_elements(html, "h1") # h1タグ
h1

  # idや属性名での要素の取得
  # 15_07_scrape-html-element-id.R
html |> html_elements("#text_1") # id = "text_1"
html |> 
  html_elements(".list") |>      # class = "list"
  html_elements("option")        # さらにoptionタグで絞り込み
html |> html_elements("[href]")  # href属性

  # XPathでの要素の取得
  # 15_08_scrape-html-xpath.R
html |>
  html_elements(xpath = "/html/body/div[5]/h1")

  # 文字列の取り出し
  # 15_09_scrape-html-text.R
html_text(h1)

  # 文字列の取り出し(ブラウザ的な表示)
  # 15_10_scrape-html-text2.R
html |>
  html_elements("p") |>
  html_text()
html |>
  html_elements("p") |>
  html_text2()

  # 属性値の取り出し
  # 15_11_scrape-html-attr.R
html |>
  html_elements("a") |>
  html_attr("href")
html |>
  html_elements("img") |>
  html_attr("src")

  # htmlの読み込み
  # 15_12_scrape-html-table.R
tables <- 
  html |>
  html_table()
tables[[1]]
tables[[2]]

  # セッションの開始
  # 15_13_scrape-selenider-session.R
session <- selenider_session(session = "chromote", timeout = 10)

  # URLを開いてブラウザで確認
  # 15_14_scrape-selenider-open-url.R
url <- "https://matutosi.github.io/r-auto/data/sample.html"
open_url(url)
session$driver$view()

  # HTMLの内容の取得
  # 15_15_scrape-selenider-get-page-source.R
html <- get_page_source(session)
{html_document}
<html lang="ja">
[1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">\n<meta charset="UTF-8">\n<title>HTMLの例</title>\n< ...
[2] <body>\n<div class="header">ヘッダーの部分\n  <a href="https://github.com/matutosi/r-auto">サポートページへ</a>\n</div>\n<hr>\n<div class="t ...
rvest::html_table(html) |>
  `[[`(_, 1)
  ##

  # 要素の取得
  # 15_16_scrape-selenider-s.R
s("#spring_species") # id"spring_species"
s("ul") # ulタグ
ss(".img") # imgクラス

  # XPathでの要素の取得
  # 15_17_scrape-selenider-s-xpath.R
s(xpath = "/html/body/div[2]/h1")

  # 文字列の取り出し
  # 15_18_scrape-selenider-text.R
s("#text_1") |>
  elem_text()
ss("option") |>
  as.list() |>
  purrr::map_chr(elem_text)

  # 属性値の取り出し
  # 15_19_scrape-selenider-attr.R
ss("a") |>
  as.list() |>
  purrr::map_chr(elem_attr, "href")

  # HTMLの内容の取得
  # 15_20_scrape-cran-read-html.R
url <- 
  "https://cran.r-project.org/web/packages/available_packages_by_name.html"
html <- read_html(url)
html

  # パッケージ一覧の取得
  # 15_21_scrape-cran-html-table.R
pkgs <-
  html |>
  html_table(header = TRUE) |>
  `[[`(_, 1) |> # [[1]]と同じ
  magrittr::set_colnames(c("pkg", "description")) |>
  dplyr::mutate(
    description = stringr::str_replace_all(description, "\n", " "))
pkgs

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
  # 15_23_search_cran_pkgs-fun.R
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

  # パッケージの検索例
  # 15_24_scrape-search-cran.R
pkgs <- scrape_cran_pkgs()
pattern = stringr::regex("GPT|OpenAI", ignore_case = TRUE)
pkg_gpt <- search_cran_pkgs(pkgs, pattern)

  # パッケージの検索例
  # 15_25_scrape-browse-cran-shell-exec.R
purrr::walk(pkg_gpt$url, shell.exec) # ブラウザで閲覧して確認

  # 新刊情報のページ一覧を取得する関数
  # 15_26_scrape-.R
get_monthly_urls <- function(){
  Sys.sleep(5)
  "https://www.morikita.co.jp/news/category/newbook" |>
    rvest::read_html() |>
    rvest::html_elements(".news_item") |> # "news_item"クラス
    rvest::html_elements("a") |>          # <a>タグ
    rvest::html_attr("href")              # hrefの属性値
}

  # 新刊情報のページ一覧を取得
  # 15_27_scrape-monthly-urls.R
monthly_urls <- get_monthly_urls()
head(monthly_urls, 2)
  # shell.exex(monthly_urls[2]) # 1つ目のページを開く

  # 新刊紹介の個別ページを取得する関数
  # 15_28_scrape-book-urls-fun.R
get_new_book_urls <- function(url){
  Sys.sleep(5)
  url |> 
    rvest::read_html() |>
    rvest::html_elements("a.book_title.show_pc") |>
    rvest::html_attr("href") 
}

  # 新刊紹介の個別ページの取得
  # 15_29_scrape-books-urls.R
new_book_urls <- 
  monthly_urls[1:2] |> # 全ての月のときは不要
  purrr::map(get_new_book_urls) |>
  unlist()
new_book_urls

  # 個別ページの内容を取得する関数
  # 15_30_scrape-books-detail-urls-fun.R
get_book_html <- function(url){
  Sys.sleep(5)
  rvest::read_html(url)
}

  # 個別ページの内容の取得
  # 15_31_scrape-books-detail-urls.R
bk_details <- purrr::map(new_book_urls, get_book_html)
bk_details[[1]]

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

  # 新刊の詳細情報の取得
  # 15_33_scrape-books-details.R
bk_details[[1]] |>
  detail2df()

  # 新刊情報の取得(まとめ)
  # 15_34_scrape-books-all.R
monthly_urls <- get_monthly_urls()
new_book_urls <-
  purrr::map(monthly_urls, get_new_book_urls) |> 
  unlist()
bk_details <- list()
for(i in seq_along(new_book_urls)){
  bk_details[[i]] <- 
    new_book_urls[i] |>
    get_book_html() |>
    detail2df()
}
bk_details <- dplyr::bind_rows(bk_details)
bk_details

  # 新刊の詳細情報の取得
  # 15_35_scrape-books-write-xlsx.R
bk_xlsx <- fs::path_temp("book.xlsx")
openxlsx::write.xlsx(bk_details, bk_xlsx)
  # shell.exec(bk_xlsx)

  # フォーム要素の取得
  # 15_36_scrape-books-form.R
url <- "https://www.morikita.co.jp/news/category/newbook"
form <- 
  url |>
  rvest::read_html() |>
  rvest::html_form() |>
  `[[`(_, 1)
form

  # フォームへの文字列の入力
  # 15_37_scrape-books-form-set.R
search <- rvest::html_form_set(form, keywords = "テキストマイニング")
search

  # フォームの送信
  # 15_38_scrape-books-form-submit.R
response <- html_form_submit(search)
html <- rvest::read_html(response)
html_elements(html, "h3")

  # seleniderでのフォームの取得と送信
  # 15_39_scrape-books-form-selenider.R
session <- selenider::selenider_session(session = "chromote", timeout = 10)
selenider::open_url(url)
  # session$driver$view()                         # ブラウザを表示するとき
selenider::s(".searchWindow-input") |>            # フォームの入力位置の要素
  selenider::elem_set_value("テキストマイニング") # フォームへの入力
selenider::s(".btn") |>                           # 検索ボタンの要素
  elem_click()                                    # 検索ボタンをクリック
selenider::ss("h3")

  # 雨雲の動きを開く
  # 15_40_scrape-jma-open-url.R
latitude <- "34.72"
longitude <- "135.30"
zoom <- "12"
url <- 
  paste0("https://www.jma.go.jp/bosai/nowc/#",
         "lat:", latitude, "/lon:", longitude, "/zoom:", zoom, 
         "/colordepth:normal/elements:hrpns&slmcs&slmcs_fcst")
session <- selenider_session(session = "chromote", timeout = 10)
open_url(url)
session$driver$view()

  # 広告非表示をクリック
  # 15_41_scrape-jma-elem-click-1.R
s("div.mdc-button__label") |>
  elem_click()

  # スクリーンショットを撮る
  # 15_42_scrape-jma-elem-click-2.R
png <- fs::file_temp(ext = "png")
take_screenshot(png)
  # shell.exec(png)

  # 時間を進める
  # 15_43_scrape-jma-elem-click-3.R
s(xpath = "/html/body/div[2]/div[1]/div[3]/div[1]/button[2]") |>
  elem_click()

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

