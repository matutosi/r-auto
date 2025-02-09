  # 列の選択
  # 02_14_analysis-dplyr-select.R
dplyr::select(answer, id, area, years) |> head(3) # 列を選択
dplyr::select(sales, -c(period, item)) |> head(3) # 列を除外

