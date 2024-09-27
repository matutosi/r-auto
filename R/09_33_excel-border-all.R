  # データの範囲に罫線を引く
  # 09_33_excel-border-all.R
walk_wb(wb, set_border, border = c("bottom", "right"))
walk_wb(wb, set_col_width)
saveWorkbook(wb, file_border, overwrite = TRUE)

