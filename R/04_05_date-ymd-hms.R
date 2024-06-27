  # 時刻の計算
  # 04_05_date-ymd-hms.R
d <- ymd_hms("2024-4-10-9-00-00")
magrittr::add(d, 105 * 60)    # 105分後
magrittr::subtract(d, 3 * 60) # 3分前

