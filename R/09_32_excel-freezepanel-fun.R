  # ウィンドウ枠を固定する関数
  # 09_32_excel-freezepanel-fun.R
  # freezePane()の糖衣関数
freeze_pane <- function(wb, sheet){
  openxlsx::freezePane(wb, sheet, firstRow = TRUE, firstCol = TRUE)
}

