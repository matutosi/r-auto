  # Googleドライブからのファイルのダウンロード(擬似コード)
  # 09_09_excel-read-googledrive.R
install.packages("googledrive")
library(googledrive)
googledrive::drive_auth("YOURNAME@gmail.com") # 認証画面でパスワード等を入力
sheet <- googledrive::drive_find(pattern = "検索文字列", type = "spreadsheet")
path <- "DIRECORY/FILE_NAME.csv"
googledrive::drive_download(
  sheet$name, path = path, type = "csv", overwrite = TRUE) # 上書きするとき

