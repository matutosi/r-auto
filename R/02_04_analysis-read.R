  # 集計用データの読み込み
  # 02_04_analysis-read.R
wd <- fs::path_temp()
setwd(wd)
files <- c("answer.xlsx", "attribute.xlsx", "sales.xlsx", "unit_price.xlsx")
urls <- paste0("https://matutosi.github.io/r-auto/data/", files)
curl::multi_download(urls)
answer <- readxl::read_excel(files[1])
attribute <- readxl::read_excel(files[2])
sales <- read_all_sheets(files[3]) |> dplyr::bind_rows()
unit_price <- readxl::read_excel(files[4])

