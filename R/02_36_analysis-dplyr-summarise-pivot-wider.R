  # 集計後の表示変更
  # 02_36_analysis-dplyr-summarise-pivot-wider.R
sales |>
  dplyr::summarise(sum = round(sum(amount) / 1000), .by = c(period, shop)) |>
  tidyr::pivot_wider(names_from = shop, values_from = sum)

