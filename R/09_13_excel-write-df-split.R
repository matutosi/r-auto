  # 分割したデータフレームのエクセルのシートごとへの書き込み
  # 09_13_excel-write-df-split.R
iris |>
  split(iris$Species) |>
  write.xlsx(file_wb)

