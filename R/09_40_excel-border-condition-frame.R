  # データの外枠に1点鎖線を引く
  # 09_40_excel-border-condition-frame.R
wb <- loadWorkbook(file_timetable)
walk_wb(wb, border_frame)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

