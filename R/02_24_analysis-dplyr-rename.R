  # 列名の変更
  # 02_24_analysis-dplyr-rename.R
sales <- dplyr::rename(sales, shop = sheet)
head(sales, 3)

