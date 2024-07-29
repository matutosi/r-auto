  # 全てのシートでのウィンドウ枠の固定
  # 09_29_excel-freezepanel-all.R
wb <- loadWorkbook(file_timetable)
map_wb(wb, freeze_pane)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

