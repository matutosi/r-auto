count_multi <- function(df, col, sep = "[^[:alnum:]]+", group_add = TRUE){
  df |>
    tidyr::separate_rows(tidyselect::all_of(col), sep = sep) |>  # 縦に分割
    dplyr::filter({{ col }} != "") |>                            # 空を除去
    dplyr::filter(!is.na({{ col }})) |>                          # NAを除去
    dplyr::group_by(dplyr::pick({{ col }}), .add = group_add) |> # グループ化
    dplyr::tally() |>                                            # 個数
    dplyr::filter({{ col }} != "")                               # 空を除去
}
split_by <- function(df, group){
  split(df, df[[group]])
}
error_if_two <- function(x){ # 0のときにエラーになる関数
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}
paste_if_not_exist <- function(x, y){
  pattern <- paste0("(^|;)+", y, "(;|$)+")
  if(stringr::str_detect(x, pattern)){
    x
  }else{
    paste0(x, ";", y)
  }
}
