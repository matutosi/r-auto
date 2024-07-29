  # コードを簡潔にするための糖衣関数
  # 09_25_excel-autofilter-wrapper-fun.R
  # addFilter()の糖衣関数
add_filter <- function(wb, sheet, rows = 1){
  cols <- cols_wb_sheet(wb, sheet)
  openxlsx::addFilter(wb, sheet, rows = rows, cols = cols)
}
  # setColWidths()の糖衣関数
set_col_width <- function(wb, sheet, width = "auto", ...){
  cols <- cols_wb_sheet(wb, sheet)
  openxlsx::setColWidths(wb, sheet, cols = cols, width = width, ...)
}
  # wbとsheetでの列数を取得
cols_wb_sheet <- function(wb, sheet){
  openxlsx::readWorkbook(wb, sheet) |> 
    ncol() |> seq()
}

