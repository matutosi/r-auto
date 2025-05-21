  # csvなどの読み込み
  # 09_02_excel-readr-read.R
file_csv <- readr::readr_example("mtcars.csv")
readr::read_csv(file_csv, show_col_types = FALSE) # CSV(カンマ区切り)
  # readr::read_tsv(ファイル名)                   # TSV(タブ区切り)
  # readr::read_delim(ファイル名, delim = ",")    # delim：区切り文字

