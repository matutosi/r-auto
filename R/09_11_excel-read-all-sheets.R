  # エクセルの全シートを読み込む
  # 09_11_excel-read-all-sheets.R
url <- "https://matutosi.github.io/r-auto/data/sales.xlsx"
path <- fs::path_temp("sales.xlsx")
curl::curl_download(url, path) # urlからエクセルをダウンロード
sales <- read_all_sheets(path)
purrr::map(sales, head, 3)
dplyr::bind_rows(sales)

