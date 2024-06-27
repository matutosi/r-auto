  # セルの文字列に合わせて罫線を引く関数
  # 09_37_excel-border-condition-hour-fun.R
#' 文字列に合致する列番号の取得
content_cols <- function(wb, sheet, str){
  df <- openxlsx::readWorkbook(wb, sheet)
  which(colnames(df) == str)
}
#' 内容で二重線を引く
border_between_contents <- function(wb, sheet, border = "right", 
                                    borderStyle = "double", str){
  style <- createStyle(border = border, borderStyle = borderStyle) # 書式
  cols <- content_cols(wb, sheet, str = str)                       # 範囲
  set_border(wb, sheet, cols = cols, style = style)                # 設定
}

