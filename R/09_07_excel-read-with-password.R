  # パスワード付きのエクセルファイルを開く疑似コード
  # 09_07_excel-read-with-password.R
library(RDCOMClient) # ないとエラーになる
excel.link::xl.read.file("ファイル名.xlsx",  password = "パスワード")

