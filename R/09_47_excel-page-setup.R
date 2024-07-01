  # 横向き等に設定したページ
  # 09_47_excel-page-setup.R
page_setup <- function(wb, sheet, ...){
  pageSetup(wb, sheet, ...)
}
map_wb(wb, page_setup, 
       orientation = "landscape", # 横向き, 
       fitToWidth = TRUE,         # 幅に合わせる(横1ページ)
       printTitleRows = 1)        # 1行目をタイトルに
saveWorkbook(wb, file_timetable, overwrite = TRUE)
  # shell.exec(file_timetable)

