  # データフレームの結合
  # 02_12_analysis-dplyr-join.R
answer <- dplyr::left_join(attribute, answer) # id列で結合
head(answer, 3)
sales <- dplyr::left_join(sales, unit_price, by = join_by(item == item))
head(sales, 3)

