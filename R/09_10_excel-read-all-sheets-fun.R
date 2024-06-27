  # エクセルの全シートを読み込む関数
  # 09_10_excel-read-all-sheets-fun.R
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

