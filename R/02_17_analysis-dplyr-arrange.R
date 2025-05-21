  # 並べ替え
  # 02_17_analysis-dplyr-arrange.R
dplyr::arrange(sales_joined, desc(count)) |> head(3)

