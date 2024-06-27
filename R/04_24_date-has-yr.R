  # 年の有無の判別
  # 04_24_date-has-yr.R
dates_west <- dates[!is_jp_date(dates)] # 西暦のみ
dates_west[has_yr(dates_west)] # 年あり
dates_west[!has_yr(dates_west)] # 年なし

