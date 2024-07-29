  # セルの文字列に合わせて罫線を引く関数
  # 09_37_excel-border-condition-hour-fun.R
border_between_contents <- function(wb, sheet, border = "right", 
                                    borderStyle = "double", str){
  style <- createStyle(border = border, borderStyle = borderStyle) # 書式
  cols <- content_cols(wb, sheet, str = str)                       # 範囲
  set_border(wb, sheet, cols = cols, style = style)                # 設定
}

