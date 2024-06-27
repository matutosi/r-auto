  # 単純な罫線を引く関数
  # 09_33_excel-border-fun.R
#' 罫線を引く関数
set_border <- function(wb, sheet, 
                       border = "Bottom", borderStyle = "thin", 
                       style = NULL){
  if(is.null(style)){
    style <- createStyle(border = border, borderStyle = borderStyle)
  }
  rows <- rows_wb_sheet(wb, sheet)
  cols <- cols_wb_sheet(wb, sheet)
  addStyle(wb, sheet, style = style, rows = rows, cols = cols, 
    gridExpand = TRUE,  # rowsとcolsの組み合わせで範囲を拡張
    stack = TRUE)       # 既存の書式に追加
}
#' wb, sheetでの行数
rows_wb_sheet <- function(wb, sheet){
  rows <- 
    openxlsx::readWorkbook(wb, sheet) |> 
    nrow() |> magrittr::add(1) |> seq() # +1：列名の行として1行追加
}

