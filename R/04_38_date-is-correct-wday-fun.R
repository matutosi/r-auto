  # 日付と曜日との整合性を確認する関数
  # 04_38_date-is-correct-wday-fun.R
is_correct_wday <- function(str){
  wday_orig <- extract_wday(str) # 元の曜日
  date <- date_ish2date(str)     # 日付
  wday <-                        # 日付にあう曜日
    date |>
    lubridate::wday(label = TRUE, locale = "Japanese_Japan.utf8") |>
    as.character()
  is_correct <- (wday == wday_orig) # 正しいか
  res <- list(is_correct = is_correct, date_orig = str,
              wday_orig = wday_orig, date = date, wday = wday)
  return(res)
}

