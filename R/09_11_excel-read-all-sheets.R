  # エクセルの全シートを読み込む
  # 09_11_excel-read-all-sheets.R
  # path <- "D:/matu/work/ToDo/r-auto/data/sales.xlsx"
path <- "https://matutosi.github.io/r-auto/data/sales.xlsx"
sales <- read_all_sheets(path)
purrr::map(sales, head, 3)
dplyr::bind_rows(sales)

