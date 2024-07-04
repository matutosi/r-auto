  # セルの内容の区別で罫線を引く関数
  # 09_35_excel-border-condition-fun.R
  # 区別として罫線を引く位置
new_categ_rows <- function(wb, sheet, col_name, include_end = FALSE){
  df <- openxlsx::readWorkbook(wb, sheet)
  old_categ <- df[[col_name]] != dplyr::lag(df[[col_name]]) # lag：1つずらす
  old_categ <- c(1, which(old_categ)) # 1: タイトル行
  if(include_end){ # 最後のカテゴリの終わりを含める
    old_categ <- c(old_categ, nrow(df) + 1) # nrow(df)+1：最終行の次
  }
  new_categ <- old_categ + 1 # タイトルの分として+1する
  return(new_categ)
}
  # 学年別で太線を引く
border_between_categ <- function(wb, sheet, categ){
  style <- createStyle(border = "top", borderStyle = "thick") # 書式
  rows <- new_categ_rows(wb, sheet, categ)                    # 範囲
  set_border(wb, sheet, rows = rows, style = style)           # 設定
}
  # set_border()の拡張版
set_border <- function(wb, sheet, rows = NULL, cols = NULL, 
                       border, borderStyle, style = NULL, 
                       gridExpand = TRUE){
    if(is.null(style)){
        style <- createStyle(border = border, borderStyle = borderStyle)
    }
    if(is.null(rows)){ rows <- rows_wb_sheet(wb, sheet) }
    if(is.null(cols)){ cols <- cols_wb_sheet(wb, sheet) }
    addStyle(wb, sheet, style = style, rows = rows, cols = cols, 
             gridExpand = TRUE,  # rowsとcolsの組み合わせで範囲を拡張
             stack = TRUE)       # 既存の書式に追加
}

