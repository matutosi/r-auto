  # 和暦の変換
  # 04_19_date-convert-jdate.R
  # 和暦はOK
dates[c(1:3, 11:13, 21:23, 31:33)] |>
  print() |>
  zipangu::convert_jdate()
  # 西暦はダメ
dates[c(4:6, 14:16, 24:26, 34:36)] |>
  print() |>
  zipangu::convert_jdate()

