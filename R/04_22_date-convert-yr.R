  # 西暦年と和暦年の変換
  # 04_22_date-convert-yr.R
str <- c("昭和50", "1992", "令和元年", "2024年")
convert_yr(str, out_format = "jp")
convert_yr(str, out_format = "west")

