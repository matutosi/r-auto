  # 元の書式のまま曜日のみ置換する関数
  # 06_27_date-replace-wday-fun.R
replace_wday <- function(str, wday_orig, wday){
  pattern <- paste0("([\\(（])", wday_orig, "([\\)）])") # 置換前
  replacement <- paste0("\\1", wday, "\\2")              # 置換後
  date <- stringr::str_replace(str, pattern, replacement)
  return(date)
}

