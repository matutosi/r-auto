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

