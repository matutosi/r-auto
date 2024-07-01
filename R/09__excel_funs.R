read_all_sheets <- function(path, add_sheet_name = TRUE){
  sheets <- openxlsx::getSheetNames(path)
  xlsx <- 
    sheets |>
    purrr::map(~openxlsx::read.xlsx(path, sheet = .)) |>
    purrr::map(tibble::tibble)
  names(xlsx) <- sheets
  if(add_sheet_name){
    xlsx <- purrr::map2(xlsx, sheets, ~dplyr::mutate(.x, sheet = .y))
  }
  return(xlsx)
}
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
map_wb <- function(wb, fun, ...){
  res <- 
    openxlsx::sheets(wb) |>       # シート名を取得
    purrr::map(fun, wb = wb, ...) # fun(wb = wb, sheet = sheet)のように受け取る
  return(invisible(res)) # 非表示で返す
}
add_filter <- function(wb, sheet, rows = 1){
  cols <- cols_wb_sheet(wb, sheet)
  openxlsx::addFilter(wb, sheet, rows = rows, cols = cols)
}
set_col_width <- function(wb, sheet, width = "auto", ...){
  cols <- cols_wb_sheet(wb, sheet)
  openxlsx::setColWidths(wb, sheet, cols = cols, width = width, ...)
}
cols_wb_sheet <- function(wb, sheet){
  openxlsx::readWorkbook(wb, sheet) |> 
    ncol() |> seq()
}
freeze_pane <- function(wb, sheet){
  openxlsx::freezePane(wb, sheet, firstRow = TRUE, firstCol = TRUE)
}
set_border <- function(wb, sheet, 
rows_wb_sheet <- function(wb, sheet){
  rows <- 
    openxlsx::readWorkbook(wb, sheet) |> 
    nrow() |> magrittr::add(1) |> seq() # +1：列名の行として1行追加
}
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
border_between_categ <- function(wb, sheet, categ){
  style <- createStyle(border = "top", borderStyle = "thick") # 書式
  rows <- new_categ_rows(wb, sheet, categ)                    # 範囲
  set_border(wb, sheet, rows = rows, style = style)           # 設定
}
set_border <- function(wb, sheet, rows = NULL, cols = NULL, 
content_cols <- function(wb, sheet, str){
  df <- openxlsx::readWorkbook(wb, sheet)
  which(colnames(df) == str)
}
content_cols <- function(wb, sheet, str){
  df <- openxlsx::readWorkbook(wb, sheet)
  which(colnames(df) == str)
}
border_between_contents <- function(wb, sheet, border = "right", 
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
set_bg_color <- function(wb, sheet, color = "#FFFF00", strings){
  bg_color <- openxlsx::createStyle(bgFill = color)
  for(str in strings){ # stringの数だけ繰り返し
    openxlsx::conditionalFormatting(wb, sheet, 
      rows = rows_wb_sheet(wb, sheet), 
      cols = cols_wb_sheet(wb, sheet), 
      rule = str, style = bg_color, type = "contains")
  }
}
page_setup <- function(wb, sheet, ...){
  pageSetup(wb, sheet, ...)
}
breaks <- function(wb, sheet, col_name){
  res <- 
    new_categ_rows(wb, sheet, col_name, 
                   include_end = TRUE)[-1] |> # [-1]：タイトル行の区切りを削除
    magrittr::subtract(1) # subtract(1)は-1と同じ：区切りの上で改ページするため
}
page_break <- function(wb, sheet, type = "row", col_name){
  brks <- breaks(wb, sheet, col_name)
  openxlsx::pageBreak(wb, sheet, i = brks, type) 
}
compare_page_break <- function(breaks, page_size = 30){
  page_size_next <- page_size                              # 最大行数の初期値
  page_breaks <- NULL                                      # 結果を返す変数
  while(length(breaks) > 1){                               # 改ページが複数
    is_under_page_brekas <- which(breaks < page_size_next) # 最大行数と比較
    if(length(is_under_page_brekas) == 0){                 # 最大行数以上
      message("Page breaks is OVER Page Size!")
      return(breaks)
    }
    index <- max(is_under_page_brekas)                     # 最大値の位置
    page_breaks <- c(page_breaks, breaks[index])           # 改ページの追加
    page_size_next <- breaks[index] + page_size            # 次の最大行数
    if(length(breaks) == index){                           # 改ページ終了
      return(page_breaks)
    }
    breaks <- breaks[(index + 1):length(breaks)]           # 残りの改ページ
  }
  is_under_page_brekas <- which(breaks < page_size_next)   # 最大行数と比較
  if(length(is_under_page_brekas) == 0){                   # 最大行数以上
    message("Page breaks is OVER Page Size!")
  }
  return(c(page_breaks, breaks))
}
add_page_break <- function(wb, sheet, col_name, page_size = 30){
  breaks <- 
    new_categ_rows(wb, sheet, col_name, 
                   include_end = TRUE)[-1] |> # [-1]：タイトル行の区切りを削除
    magrittr::subtract(1)    # subtract(1)は-1と同じ：区切りの上で改ページ
  breaks <- compare_page_break(breaks, page_size)
  openxlsx::pageBreak(wb, sheet, breaks)
}
xlsx2pdf <- function(path){
  format_no <- 57                                         # PDFの番号
  path <- normalizePath(path)                             # Windows形式に変換
  converted <- 
    fs::path_ext_remove(path) |>                          # 拡張子除去
    normalizePath(mustWork = FALSE)
  xlsxApp <- RDCOMClient::COMCreate("Excel.Application")  # エクセルの操作
  xlsx <- xlsxApp$workbooks()$Open(path)                  # ファイルを開く
  xlsx$SaveAs(converted, FileFormat = format_no)          # 指定形式で保存
  xlsx$close()                                            # エクセルを閉じる
  converted <- fs::path_ext_set(converted, "pdf")         #  拡張子の設定
  return(converted)
}
