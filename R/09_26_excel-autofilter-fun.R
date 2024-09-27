  # 全シートでのオートフィルタと列幅の設定
  # 09_26_excel-autofilter-fun.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, add_filter)
walk_wb(wb, set_col_width)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

