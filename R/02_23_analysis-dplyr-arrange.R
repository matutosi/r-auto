  # 並べ替え
  # 02_23_analysis-dplyr-arrange.R
dplyr::arrange(answer, period) |> head(3)
dplyr::arrange(sales, desc(count)) |> head(3)

