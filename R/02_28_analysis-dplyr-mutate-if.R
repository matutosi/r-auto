  # 指定列の追加
  # 02_28_analysis-dplyr-mutate-if.R
dplyr::mutate_if(answer, is.numeric, magrittr::multiply_by, 100) |> head(3)

