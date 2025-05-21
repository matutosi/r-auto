  # データフレームの結合
  # 02_12_analysis-dplyr-join.R
answer_joined <- # data/answer_joined.csv
  dplyr::left_join(attribute, answer_tidy) # id列で結合
head(answer_joined, 3)
sales_joined <- # data/sales_joined.csv
  dplyr::left_join(sales_long, unit_price, by = join_by(item == item))
head(sales_joined, 3)

