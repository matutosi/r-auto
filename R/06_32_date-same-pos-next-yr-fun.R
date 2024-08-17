  # 1年後の同一位置の年月日を取得する関数
  # 06_32_date-same-pos-next-yr-fun.R
same_pos_next_yr <- function(x, out_format = "west"){
  yr <- lubridate::year(x)  # 年
  mn <- lubridate::month(x) # 月
  base <- lubridate::ymd(paste0(yr + 1, "-", mn, "-", 1)) # 1日
  diff <- lubridate::wday(x) - lubridate::wday(base) # 曜日位置の差
  diff <- dplyr::if_else(diff >= 0, diff, diff + 7)  # 負をは正に変換
  same_pos_day <- base + (mweek(x) - 1) * 7 + diff   # 同じ位置
  diff <- dplyr::if_else(diff >= 0, diff, diff + 7)  # 負は正に変換
  for(i in seq_along(same_pos_day)){
    if(month(same_pos_day[i]) != mn[i]){ # 月が異なるとき
      same_pos_day[i] <- NA              # 該当日なし
      warning("No same date as ", x[i], "!\n")
    }
  }
  same_pos_day <- # 指定の書式に変換
    format_date(same_pos_day, out_format = out_format)
  return(same_pos_day)
}

