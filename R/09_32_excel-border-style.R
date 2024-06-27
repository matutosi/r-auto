  # 設定可能な罫線の一覧作成
  # 09_32_excel-border-style.R
border <- "bottom"
style <- 
  c("thin", "medium", "dashed", "dotted", "thick", "double", 
    "hair", "mediumDashed", "dashDot", "mediumDashDot", 
    "dashDotDot", "mediumDashDotDot", "slantDashDot")
styles <- 
  style |>
  purrr::map(~createStyle(border = border, borderStyle = .)) # 
wb <- createWorkbook() # ワークブックを作成
addWorksheet(wb, 1, zoom = 200) # シートを追加
writeData(wb, sheet = 1, style) # データ書き込み
file_border <- fs::path_temp("border.xlsx")
styles |>
  purrr::iwalk(~addStyle(wb, 1, # 罫線のスタイルを適用
  style = .x,                   # .x：style[[i]]，iは1からnまで
  rows = .y, cols = 1)  )       # .y：i
saveWorkbook(wb, file_border, overwrite = TRUE) # 書き込み

