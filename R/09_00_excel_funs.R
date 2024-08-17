  # 列幅を変更する関数
  # 09_21_excel-width-fun.R
set_col_width_auto <- function(wb_path){ # wb_path：ワークブックのパス(文字列)
  wb <- openxlsx::loadWorkbook(wb_path) # 読込
  for(sheet in sheets(wb)){             # シートごと
    cols <-                             # 列番号
      openxlsx::readWorkbook(wb, sheet) |>
      ncol() |> 
      seq() # seq(5)で1:5と同じ
    openxlsx::setColWidths(wb, sheet, cols, width = "auto") # 列幅の設定
  }
  openxlsx::saveWorkbook(wb, wb_path, overwrite = TRUE) # 書き込み
}
  # 全シートに同じ関数を実行する関数
  # 09_24_excel-autofilter-map-fun.R
map_wb <- function(wb, fun, ...){
  res <- 
    openxlsx::sheets(wb) |>       # シート名を取得
    purrr::map(fun, wb = wb, ...) # fun(wb = wb, sheet = sheet)のように受け取る
  return(invisible(res)) # 非表示で返す
}
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
  # 09_28_excel-freezepanel-fun.R
  # freezePane()の糖衣関数
freeze_pane <- function(wb, sheet){
  openxlsx::freezePane(wb, sheet, firstRow = TRUE, firstCol = TRUE)
}
  # 単純な罫線を引く関数
  # 09_31_excel-border-fun.R
set_border <- function(wb, sheet, 
                       border = "Bottom", borderStyle = "thin", 
                       style = NULL){
  if(is.null(style)){
    style <- createStyle(border = border, borderStyle = borderStyle)
  }
  rows <- rows_wb_sheet(wb, sheet) # シートごとの行数
  cols <- cols_wb_sheet(wb, sheet) # シートごとの列数
  addStyle(wb, sheet, style = style, rows = rows, cols = cols, 
    gridExpand = TRUE,  # rowsとcolsの組み合わせで範囲を拡張
    stack = TRUE)       # 既存の書式に追加
}
  # シートごとの行数を取得する関数
  # 09_32_excel-rows-wb-sheet-fun.R
rows_wb_sheet <- function(wb, sheet){
  rows <- 
    openxlsx::readWorkbook(wb, sheet) |> 
    nrow() |> magrittr::add(1) |> seq() # +1：列名の1行を追加
}
  # 09_34_excel-border-condition-fun.R
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
  # 文字列に合致する列番号を取得する関数
  # 09_36_excel-content-cols-fun.R
content_cols <- function(wb, sheet, str){
  df <- openxlsx::readWorkbook(wb, sheet)
  which(colnames(df) == str)
}
  # セルの文字列に合わせて罫線を引く関数
  # 09_37_excel-border-condition-hour-fun.R
border_between_contents <- function(wb, sheet, border = "right", 
                                    borderStyle = "double", str){
  style <- createStyle(border = border, borderStyle = borderStyle) # 書式
  cols <- content_cols(wb, sheet, str = str)                       # 範囲
  set_border(wb, sheet, cols = cols, style = style)                # 設定
}
  # データの外枠に罫線を引く関数
  # 09_39_excel-border-condition-frame-fun.R
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
  # 条件付き書式設定による背景色を変更する関数
  # 09_41_excel-bg-color-fun.R
set_bg_color <- function(wb, sheet, color = "#FFFF00", strings){
  bg_color <- openxlsx::createStyle(bgFill = color)
  for(str in strings){ # stringの数だけ繰り返し
    openxlsx::conditionalFormatting(wb, sheet, 
      rows = rows_wb_sheet(wb, sheet), 
      cols = cols_wb_sheet(wb, sheet), 
      rule = str, style = bg_color, type = "contains")
  }
}
