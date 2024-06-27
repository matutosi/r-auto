  # `hour`列の右に二重線を引く
  # 09_38_excel-border-condition-hour.R
wb <- loadWorkbook(file_timetable)
map_wb(wb, border_between_contents, str = "hour")
saveWorkbook(wb, file_timetable, overwrite = TRUE)

