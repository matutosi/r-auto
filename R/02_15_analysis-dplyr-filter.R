  # 行を抽出
  # 02_15_analysis-dplyr-filter.R
dplyr::filter(sales, 600 < price & price < 700) |> head(3)

