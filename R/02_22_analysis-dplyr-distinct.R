  # 重複の除去
  # 02_22_analysis-dplyr-distinct.R
dplyr::distinct(answer, area)
dplyr::distinct(sales, period, sheet) |> 
  print(n = 3)

