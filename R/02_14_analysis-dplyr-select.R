  # 列の選択
  # 02_14_analysis-dplyr-select.R
dplyr::select(answer, id, area, period) |> head(3)
dplyr::select(sales, -c(period, item)) |> head(3)

