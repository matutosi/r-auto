  # グループ化
  # 02_31_analysis-dplyr-group-by.R
dplyr::group_by(answer, area) |> print(n = 3)
dplyr::group_by(sales, item) |> print(n = 3)

