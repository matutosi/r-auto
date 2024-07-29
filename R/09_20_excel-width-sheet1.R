  # 列幅の設定
  # 09_20_excel-width-sheet1.R
wb <- loadWorkbook(file_timetable) # ワークブック読み込み
setColWidths(wb, 1, cols = 1:10, width = "auto")  # 列幅の変更
saveWorkbook(wb, file_timetable, overwrite = TRUE)  # ワークブックの書き込み

