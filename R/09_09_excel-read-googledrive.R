  # Googleドライブからのファイルのダウンロード(疑似コード)
  # 09_09_excel-read-googledrive.R
install.packages("googledrive")
library(googledrive)
drive_auth("YOURNAME@gmail.com") # 認証画面でパスワードなどを入力
sheet <- drive_find(pattern = "検索文字列", type = "spreadsheet")
path <- "DIRECORY/FILE_NAME.csv"
drive_download(sheet$name[1], path = path, type = "csv", overwrite = TRUE) # 上書きするとき

