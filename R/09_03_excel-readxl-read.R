  # read_excel()によるデータフレームとしての読み込み
  # 09_03_excel-readxl-read.R
path <- readxl::readxl_example("datasets.xlsx")
quakes <- readxl::read_excel(path, sheet = "quakes") # シート名を指定
quakes |> head(3)
mtcars <- readxl::read_excel(path, sheet = 1)    # シート番号を指定

