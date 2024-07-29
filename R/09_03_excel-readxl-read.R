  # read_excel()によるデータフレームとしての読み込み
  # 09_03_excel-readxl-read.R
path <- readxl::readxl_example("datasets.xlsx")
iris <- readxl::read_excel(path, sheet = "iris") # シート名
iris |> head(3)
mtcars <- readxl::read_excel(path, sheet = 2)    # 番号

