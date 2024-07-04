  # 翻訳結果のエクセルへの書き込み
  # 13_20_tidy.R
path <- fs::path_temp("sample.xlsx")
openxlsx::write.xlsx(result, path) # エクセルに一旦書き込み
wb <- openxlsx::loadWorkbook(path) # 読み込み
openxlsx::setColWidths(wb, 1, cols = 1:5, width = 40) # 列幅の変更
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)  # 書き込み
  # shell.exec(path)

