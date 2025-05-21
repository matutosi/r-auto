  # CSVなどの書き込み
  # 09_11_excel-write-txt.R
readr::write_csv(mtcars, fs::path_temp("mtcars.csv"))      # CSV(カンマ区切り)
readr::write_tsv(mtcars, fs::path_temp("mtcars.tsv"))      # TSV(タブ区切り)
readr::write_delim(iris, fs::path_temp("iris.txt"), delim = ";") # ;区切り
ls("package:readr") |>         # ほかにもいろいろとある
  stringr::str_subset("write") # 関数名が表示される(詳細はヘルプ参照)

