  # ウィンドウ枠を固定する関数
  # 09_28_excel-freezepanel-fun.R
  # freezePane()のラッパー関数
freeze_pane <- function(wb, sheet){
  openxlsx::freezePane(wb, sheet, firstRow = TRUE, firstCol = TRUE)
}

