  # 列の選択と除外
  # 02_14_analysis-dplyr-select.R
dplyr::select(answer_joined, id, area, years) |> head(3) # 列を選択
dplyr::select(sales_joined, -c(period, item)) |> head(3) # 列を除外

