  # 行を抽出
  # 02_15_analysis-dplyr-filter.R
dplyr::filter(sales_joined, 600 < price & price < 700) |> head(3)

