  # csvなどの読み込み
  # 09_02_excel-readr-read.R
file_csv <- readr::readr_example("mtcars.csv")
readr::read_csv(file_csv, show_col_types = FALSE) # CSV(カンマ区切り)
  # readr::read_tsv(FILE_NAME)                   # TSV(タブ区切り)
  # readr::read_delim(FILE_NAME, delim = ",")    # delim：区切り文字

