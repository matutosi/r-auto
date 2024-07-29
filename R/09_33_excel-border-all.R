  # データの範囲に罫線を引く
  # 09_33_excel-border-all.R
map_wb(wb, set_border, border = c("bottom", "right"))
map_wb(wb, set_col_width)
saveWorkbook(wb, file_border, overwrite = TRUE)

