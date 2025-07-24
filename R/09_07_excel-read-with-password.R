  # パスワード付きのExcelファイルを開く疑似コード
  # 09_07_excel-read-with-password.R
library(RDCOMClient) # ないとエラーになる
excel.link::xl.read.file("FILE_NAME.xlsx",  password = "PASSWORD")

