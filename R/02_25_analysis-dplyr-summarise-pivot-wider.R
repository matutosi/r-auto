  # 集計後の表示変更
  # 02_25_analysis-dplyr-summarise-pivot-wider.R
sales |>
  dplyr::summarise(sum = round(sum(count * price) / 1000), 
                   .by = c(period, shop)) |>
  tidyr::pivot_wider(names_from = shop, values_from = sum) |>
  print(n = 3)

