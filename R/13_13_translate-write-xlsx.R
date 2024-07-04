  # 翻訳結果をエクセルに書き込み
  # 13_13_translate-write-xlsx.R
path <- fs::path_temp("sample.xlsx")
openxlsx::write.xlsx(result, path)                        # エクセルに書き込み
wb <- openxlsx::loadWorkbook(path)                        # 読み込み
openxlsx::setColWidths(wb, 1, cols = 1:2, width = "auto") # 列幅の変更
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)        # 書き込み
  # shell.exec(path)

