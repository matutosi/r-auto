  # 複数回答を集計する関数
  # 02_38_analysis-dplyr-count-multi-ans-fun.R
count_multi <- function(df, col, sep = "[^[:alnum:]]+", group_add = TRUE){
  df |>
    tidyr::separate_rows(tidyselect::all_of(col), sep = sep) |>  # 縦に分割
    dplyr::filter({{ col }} != "") |>                            # 空を除去
    dplyr::filter(!is.na({{ col }})) |>                          # NAを除去
    dplyr::group_by(dplyr::pick({{ col }}), .add = group_add) |> # グループ化
    dplyr::tally() |>                                            # 個数
    dplyr::filter({{ col }} != "")                               # 空を除去
}

