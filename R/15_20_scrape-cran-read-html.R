  # HTMLの内容の取得
  # 15_20_scrape-cran-read-html.R
url <- 
  "https://cran.r-project.org/web/packages/available_packages_by_name.html"
(html <- read_html(url))

