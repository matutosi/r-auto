  # ピボットテーブルの作成
  # 09_17_excel-pivot-qpvt.R
head(diamonds)
pt_diamonds <- 
  pivottabler::qpvt(diamonds,
  rows = c("=", "color"),  # "="：結果(price，n)の表示場所・順序の指定に使う
  columns = "cut", 
  calculations = c("price" = "mean(price) |> round()", "n" = "n()"))
pt_diamonds

