  # csvなどの書き込み
  # 09_11_excel-write-txt.R
readr::write_csv(mtcars, "mtcars.csv")            # csv(カンマ区切り)
readr::write_tsv(mtcars, "mtcars.tsv")            # tsv(タブ区切り)
readr::write_delim(iris, "iris.txt", delim = ";") # delim：区切り文字
ls("package:readr") |>         # 他にも色々とある
  stringr::str_subset("write") # 詳細はヘルプ参照

