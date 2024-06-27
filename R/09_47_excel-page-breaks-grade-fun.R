  # 学年ごとに改ページを設定する関数
  # 09_47_excel-page-breaks-grade-fun.R
page_break <- function(wb, sheet, type = "row", col_name){
  brks <- breaks(wb, sheet, col_name)
  openxlsx::pageBreak(wb, sheet, i = brks, type) 
}

