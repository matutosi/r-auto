  # クロス集計
  # 02_39_analysis-dplyr-cross-summary.R
dplyr::count(answer, area, satisfy) |> # 単数回答・クロス集計
  tidyr::pivot_wider(names_from = area, values_from = n, values_fill = 0)
answer |> # 複数回答・クロス集計
  dplyr::group_by(area) |>
  count_multi("apps", sep = ";") |>
  tidyr::pivot_wider(names_from = area, values_from = n, values_fill = 0)

