  # 学年の区別で太線を引く
  # 09_37_excel-border-condition-grade.R
wb <- loadWorkbook(file_timetable)
map_wb(wb, border_between_categ, categ = "grade")
saveWorkbook(wb, file_timetable, overwrite = TRUE)

