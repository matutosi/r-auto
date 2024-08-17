  # 各曜日での序数を得る関数
  # 06_31_date-mweek-fun.R
mweek <- function(x){
  (lubridate::mday(x) + 6) %/% 7
}

