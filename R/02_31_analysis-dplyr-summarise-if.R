  # 数値の列の集計
  # 02_31_analysis-dplyr-summarise-if.R
dplyr::group_by(sales, item) |> 
  dplyr::summarise_if(is.numeric, max) |>
  print(n = 3)

