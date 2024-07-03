  # オートフィルタの設定
  # 09_27_excel-autofilter.R
wb <- loadWorkbook(file_timetable)
addFilter(wb, sheet = 1, rows = 1, cols = 1:10)
saveWorkbook(wb, file_timetable, overwrite = TRUE)  # ワークブックの書き込み

