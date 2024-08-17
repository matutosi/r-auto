  # 曜日の修正
  # 06_30_date-update-wday.R
tibble::tibble(west   = update_wday(dates, out_format = "west"),
               jp     = update_wday(dates, out_format = "jp"),
               update = update_wday(dates,out_format = "original"),
               orig   = dates) |>
  print(n = 20)

