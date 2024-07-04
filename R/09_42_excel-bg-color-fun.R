  # 条件付き書式設定による背景色を変更する関数
  # 09_42_excel-bg-color-fun.R
set_bg_color <- function(wb, sheet, color = "#FFFF00", strings){
  bg_color <- openxlsx::createStyle(bgFill = color)
  for(str in strings){ # stringの数だけ繰り返し
    openxlsx::conditionalFormatting(wb, sheet, 
      rows = rows_wb_sheet(wb, sheet), 
      cols = cols_wb_sheet(wb, sheet), 
      rule = str, style = bg_color, type = "contains")
  }
}

