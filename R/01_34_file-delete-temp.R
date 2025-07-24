  # 作業用ファイルとディレクトリの削除
  # 01_34_file-delete-temp.R
txts <- paste0(c("foo", "bar", "baz"), ".txt")
xlsxs <- dir_ls(regexp = "^\\d{3}_[a-j]\\.xlsx")
pdfs <- dir_ls(regexp = "^\\d{2}\\.pdf")
file_delete(c(txts, xlsxs, pdfs))
dir_delete("abc")

