  # 複数回答を集計する関数
  # 02_37_analysis-dplyr-count-multi-ans-fun.R
count_multi <- function(df, col, sep = "[^[:alnum:]]+", group_add = TRUE){
  df |>
    tidyr::separate_rows(tidyselect::all_of(col), sep = sep) |>  # 縦に分割
    dplyr::filter({{ col }} != "") |>                            # 空を除去
    dplyr::filter(!is.na({{ col }})) |>                          # NAを除去
    dplyr::group_by(dplyr::pick({{ col }}), .add = group_add) |> # グループ化
    dplyr::tally() |>                                            # 個数
    dplyr::filter({{ col }} != "")                               # 空を除去
}
  # リストに分割する関数の定義
  # 02_55_analysis-purrr-split-by-fun.R
split_by <- function(df, group){
  split(df, df[[group]])
}
  # 2のときにエラーになる関数
  # 02_59_analysis-purrr-safely-prep.R
error_if_two <- function(x){
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}
  # 新しいものを追加する関数
  # 02_62_analysis-purrr-paste-if-new-fun.R
paste_if_new <- function(x, y){
  pattern <- paste0("(^|;)+", y, "(;|$)+")
  if(stringr::str_detect(x, pattern)){
    x
  }else{
    paste0(x, ";", y)
  }
}
