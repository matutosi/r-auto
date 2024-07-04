  # エクセルの全シートを読み込む関数
  # 02_03_analysis-read-all-sheets-fun.R
read_all_sheets <- function(path, add_sheet_name = TRUE){
  sheets <- openxlsx::getSheetNames(path)  # シート名の一覧
  xlsx <- 
    sheets |>
    purrr::map(\(x){                       # シートごとに
      openxlsx::read.xlsx(path, sheet = x) # データの読み込み
    }) |>
    purrr::map(tibble::tibble)             # tibbleに変換
  names(xlsx) <- sheets                    # シート名
  if(add_sheet_name){                      # シート名をtibbleに追加するか
    xlsx <- purrr::map2(xlsx, sheets,
      \(.x, .y){
        dplyr::mutate(.x, sheet = .y)      # シート名の列を追加
      }
    )
  }
  return(xlsx)
}

