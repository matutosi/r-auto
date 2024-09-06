  # 縦長形式への変換
  # 02_10_analysis-tidyr-pivot-longer.R
head(sales, 3)
sales <- 
  tidyr::pivot_longer(sales, cols = !c(period, shop),  # ! は以外の意味
                      names_to = "item", values_to = "count")
head(sales, 3)

