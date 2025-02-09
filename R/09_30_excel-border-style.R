  # 設定可能な罫線の一覧作成
  # 09_30_excel-border-style.R
border <- "bottom" # 罫線の位置をセルの下に
style <-           # 罫線の種類
  c("thin", "medium", "dashed", "dotted", "thick", "double", 
    "hair", "mediumDashed", "dashDot", "mediumDashDot", 
    "dashDotDot", "mediumDashDotDot", "slantDashDot")
styles <-          # 罫線の位置と種類を設定
  style |>
  purrr::map(\(x){ createStyle(border = border, borderStyle = x) })
wb <- createWorkbook()          # ワークブックを作成
addWorksheet(wb, 1, zoom = 200) # シートを追加
writeData(wb, sheet = 1, style) # データ書き込み
file_border <- fs::path_temp("border.xlsx")
styles |>
  purrr::iwalk(\(.x, .y){      # 繰り返しをする関数
    addStyle(wb, 1,            # 罫線のスタイルを適用
    style = .x,                # .x：style[[i]]、iは1からnまで
    rows = .y, cols = 1)}      # .y：i
  )
saveWorkbook(wb, file_border, overwrite = TRUE) # 書き込み
  # shell.exec(file_border)

