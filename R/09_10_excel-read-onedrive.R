  # OneDriveからのファイルのダウンロード(擬似コード)
  # 09_10_excel-read-onedrive.R
install.packages("Microsoft365R")
library(Microsoft365R)
odb <- Microsoft365R::get_business_onedrive(tenant = "YOUR_COMPANY.OR.JP") # 認証
odb$list_files()
src <- "FILE_NAME"
dest <- "DIRECORY/FILE_NAME" # 認証画面でパスワード等を入力
odb$download_file(src = src, dest = dest, overwrite = TRUE) # 上書きするとき

