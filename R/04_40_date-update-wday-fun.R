  # 曜日を修正する関数
  # 04_40_date-update-wday-fun.R
update_wday <- function(str, out_format = "west"){
  res <- is_correct_wday(str)   # 曜日が正しいか判定
  if(out_format == "original"){ # 元の書式
    date <- replace_wday(str, res$wday_orig, res$wday)
  }else{ # 和暦か西暦
    date <- format_date(res$date, out_format = out_format)
  }
  return(date)
}

