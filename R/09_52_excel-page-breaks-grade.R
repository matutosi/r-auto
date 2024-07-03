  # 学年ごとに改ページを設定する
  # 09_52_excel-page-breaks-grade.R
wb_breaks <- wb
map_wb(wb_breaks, page_break, type = "row", "grade")
file_timetable_breaks <- 
  fs::path_temp("timetable_breaks.xlsx") # 別名で書き込み
saveWorkbook(wb_breaks, file_timetable_breaks, overwrite = TRUE)

