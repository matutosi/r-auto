  # シートごとの行数を取得する関数
  # 09_34_excel-rows_wb-sheet-fun.R
rows_wb_sheet <- function(wb, sheet){
  rows <- 
    openxlsx::readWorkbook(wb, sheet) |> 
    nrow() |> magrittr::add(1) |> seq() # +1：列名の行として1行追加
}

