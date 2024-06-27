  # 列の追加
  # 02_26_analysis-dplyr-mutate-new-col.R
sales <- dplyr::mutate(sales, amount = count * price)
head(sales, 3)

