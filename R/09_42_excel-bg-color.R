  # 条件付き書式設定による背景色の変更
  # 09_42_excel-bg-color.R
map_wb(wb, set_bg_color, color = "yellow", strings = c("衣", "食", "住"))
saveWorkbook(wb, file_timetable, overwrite = TRUE)
  # shell.exec(file_timetable)

