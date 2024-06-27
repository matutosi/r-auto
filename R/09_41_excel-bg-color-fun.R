  # 条件付き書式設定による背景色を変更する関数
  # 09_41_excel-bg-color-fun.R
#' stringsの文字列を含むものに背景色を適用
#' @params color 背景色
#' @params strings：c("abc", "xyz")などの文字列ベクトル
set_bg_color <- function(wb, sheet, color = "#FFFF00", strings){
  bg_color <- openxlsx::createStyle(bgFill = color)
  for(str in strings){ # stringの数だけ繰り返し
    openxlsx::conditionalFormatting(wb, sheet, 
      rows = rows_wb_sheet(wb, sheet), 
      cols = cols_wb_sheet(wb, sheet), 
      rule = str, style = bg_color, type = "contains")
  }
}

