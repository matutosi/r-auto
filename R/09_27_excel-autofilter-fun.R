  # 全シートでのオートフィルタと列幅の設定
  # 09_27_excel-autofilter-fun.R
wb <- loadWorkbook(file_timetable)
map_wb(wb, add_filter)
map_wb(wb, set_col_width)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

