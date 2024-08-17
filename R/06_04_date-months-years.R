  # 日付を操作する関数
  # 06_04_date-months-years.R
day_base <- ymd("2024-03-31")
day_base + months(1:4) # months()はbaseの関数
day_base + years(1:4) # 1-4年後まで

