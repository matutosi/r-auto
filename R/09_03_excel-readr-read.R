  # csvなどの読み込み
  # 09_03_excel-readr-read.R
file_csv <- readr::readr_example("mtcars.csv")
readr::read_csv(file_csv, show_col_types = FALSE) # csv(カンマ区切り)
  # readr::read_tsv(ファイル名)                   # tsv(タブ区切り)
  # readr::read_delim(ファイル名, delim = ",")    # delim：区切り文字

