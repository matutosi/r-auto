  # 日付を操作する関数
  # 04_07_date-months-years.R
day_base <- ymd("2024-04-03")
day_base + months(1:4) # months()はbaseの関数
day_base + years(1:4) # 1-4年後まで
day_base + days(365 * 1:4) # + years()とは異なる
ymd("2024-02-29") + years(0:4) # 該当日がないときはNA

