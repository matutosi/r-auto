  # 縦長形式への変換
  # 02_13_analysis-tidyr-pivot-longer.R
head(sales, 5)
sales <- 
  tidyr::pivot_longer(sales, cols = !c(period, sheet),  # ! は以外の意味
                      names_to = "item", values_to = "count")
head(sales, 5)

