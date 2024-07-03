  # ページ内に複数学年を許容して改ページを設定
  # 09_56_excel-page-compare-add-breaks.R
map_wb(wb, add_page_break, col_name = "grade", page_size = 30)
saveWorkbook(wb, file_timetable, overwrite = TRUE)

