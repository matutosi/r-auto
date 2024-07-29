  # 日付っぽい文字列
  # 04_07_date-for-check.R
dates <- c("令和6年5月26日", "令和6.5.26", "R6.05.26",
            "2024年7月23日",  "2024-7-23", "24.7.23",
            "20240723", "240723", "11.27", "1127")
dates_half <- c(dates, paste0(dates, "(日)"))
dates_full <- stringi::stri_trans_general(dates_half, "halfwidth-fullwidth")
dates <- c(dates_half, dates_full)
dates[c(1:10, 11, 21, 25, 27, 35)] # 代表的なもののみ表示

