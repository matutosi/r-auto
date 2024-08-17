  # 1年後の同一位置の年月日の取得
  # 06_33_date-same-pos-next-yr.R
x <- ymd("2024-05-01")
days <- x + 0:30
days
days_next_yr <- same_pos_next_yr(days)
days_next_yr

