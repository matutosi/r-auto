  # 文字列に合致する列番号を取得する関数
  # 09_40_excel-content-cols-fun.R
content_cols <- function(wb, sheet, str){
  df <- openxlsx::readWorkbook(wb, sheet)
  which(colnames(df) == str)
}

