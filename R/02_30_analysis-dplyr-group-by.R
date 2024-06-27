  # グループ化
  # 02_30_analysis-dplyr-group-by.R
dplyr::group_by(answer, area) |> print(n = 3)
dplyr::group_by(sales, item) |> print(n = 3)

