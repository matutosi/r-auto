  # 横向き等にページを設定する
  # 09_46_excel-page-setup.R
map_wb(wb, page_setup, 
       orientation = "landscape", # 横向き, 
       fitToWidth = TRUE,         # 幅に合わせる(横1ページ)
       printTitleRows = 1)        # 1行目をタイトルに
saveWorkbook(wb, file_timetable, overwrite = TRUE)
  # shell.exec(file_timetable)

