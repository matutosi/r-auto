  # データの外枠に罫線を引く関数
  # 09_40_excel-border-condition-frame-fun.R
border_frame <- function(wb, sheet, borderStyle = "mediumDashDot"){
  # 書式
  style_t <- createStyle(border = "top",    borderStyle = borderStyle)
  style_b <- createStyle(border = "bottom", borderStyle = borderStyle)
  style_l <- createStyle(border = "left",   borderStyle = borderStyle)
  style_r <- createStyle(border = "right",  borderStyle = borderStyle)
  # 範囲
  rows <- rows_wb_sheet(wb, sheet)
  cols <- cols_wb_sheet(wb, sheet)
  rows_t <- 1
  rows_b <- max(rows)
  cols_l <- 1
  cols_r <- max(cols)
  # 書式の適用
  set_border(wb, sheet, rows = rows_t, cols = cols  , style = style_t) # 上
  set_border(wb, sheet, rows = rows_b, cols = cols  , style = style_b) # 下
  set_border(wb, sheet, rows = rows  , cols = cols_l, style = style_l) # 左
  set_border(wb, sheet, rows = rows  , cols = cols_r, style = style_r) # 右
}

