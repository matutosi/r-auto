  # 行を抽出
  # 02_20_analysis-dplyr-filter.R
dplyr::filter(answer, satisfy == "5") |> head(3)
dplyr::filter(sales, 600 < price & price < 700) |> head(3)

