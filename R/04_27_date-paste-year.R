  # 年の追加
  # 04_27_date-paste-year.R
  # today()が2024年1月2日-12月30日のとき
str <- "12-31"
paste_year(str)
paste_year(str, past = TRUE)
str <- "1-1"
paste_year(str)
paste_year(str, past = TRUE)

