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
  # 複数回答を集計する関数
  # 02_26_analysis-dplyr-count-multi-ans-fun.R
count_multi <- function(df, col, delim = "[^[:alnum:]]+", group_add = TRUE){
  df |>
    tidyr::separate_longer_delim(tidyselect::all_of(col),        # 縦に分割
                                 delim = delim) |> 
    dplyr::filter({{ col }} != "") |>                            # 空を除去
    dplyr::filter(!is.na({{ col }})) |>                          # NAを除去
    dplyr::group_by(dplyr::pick({{ col }}), .add = group_add) |> # グループ化
    dplyr::tally() |>                                            # 個数
    dplyr::filter({{ col }} != "")                               # 空を除去
}
  # 2のときにエラーになる関数
  # 02_48_analysis-purrr-safely-prep.R
error_if_two <- function(x){
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}
  # 新しいものを追加する関数
  # 02_51_analysis-purrr-paste-if-new-fun.R
paste_if_new <- function(x, y){
  pattern <- paste0("(^|;)+", y, "(;|$)+")
  if(stringr::str_detect(x, pattern)){
    x
  }else{
    paste0(x, ";", y)
  }
}
