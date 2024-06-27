  # read_excel()によるデータフレームとしての読み込み
  # 09_04_excel-readxl-read.R
  # エクセルの1つのシートをデータフレームとして読み込む
path <- readxl::readxl_example("datasets.xlsx")
iris <- readxl::read_excel(path, sheet = "iris") # シート名
iris |> head(3)
mtcars <- readxl::read_excel(path, sheet = 2)    # 番号

