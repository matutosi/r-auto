  # 日付っぽい文字列の正規表現を返す関数
  # 04_13_date-date-ish-fun.R
date_ish <- function(){
  era <- "([MTSHRＭＴＳＨＲ]|明治|大正|昭和|平成|令和)?"
  yr <- "[\\d元]{0,4}[-－.．_＿/／年]?"
  mn <- "\\d{1,2}[-－.．_＿/／月]"
  dy <- "\\d{1,2}日?"
  dw <- "([\\(（][月火水木金土日祝]+[\\)）])?"
  mn_dy <- "(0[1-9]|[12][0-9]|3[01])" # 月日
  yr_4 <-  "(19|20)?[0-9]{2}"         # 2桁か4桁の年
  p_1 <- paste0(era, yr, mn, dy, dw)
  p_2 <- paste0(      mn_dy)          # 数字のみの月日
  p_3 <- paste0(yr_4, mn_dy)          # 数字のみの年月日
  pattern <- paste(p_1, p_2, p_3, sep = "|")
  return(pattern)
}
  # 日付っぽい文字列を抽出する関数
  # 04_16_date-extract-date-ish-fun.R
extract_date_ish <- function(str, simplify = FALSE){
  pattern <- date_ish()
  res <-
    stringr::str_extract_all(str, pattern = pattern, simplify = simplify)
  if(length(res) == 1){
    res <- res[[1]]
  }
  return(res)
}
  # 和暦判別の関数
  # 04_20_date-is-jp-date-fun.R
is_jp_date <- function(str){
  era <- "^([MTSHRＭＴＳＨＲ]|明治|大正|昭和|平成|令和)[\\d元]"
  stringr::str_detect(str, era)
}
  # 年の有無の判別関数
  # 04_23_date-has-yr-fun.R
has_yr <- function(str){
  dw <- "\\([月火水木金土日祝]+\\)$"
  str <-
    str |>
    stringi::stri_trans_general("fullwidth-halfwidth") |>
    stringr::str_remove(dw) |>                              # 曜日を削除
    stringr::str_remove("日$")                              # 最後の"日"を削除
  res <-
    dplyr::if_else(stringr::str_count(str, "[^0-9]") == 0,  # [^0-9]：数字以外
      dplyr::if_else(stringr::str_count(str, "[0-9]") >= 6, # 数字のみ
              TRUE,                                         # 6桁以上
              FALSE),                                       # 5桁以下
      dplyr::if_else(stringr::str_count(str, "[^0-9]") >= 2, # 数字以外あり
              TRUE,                           # 区切り文字が2つ以上：年あり
              FALSE)                          # 区切り文字が1つ：年なし
    )
  return(res)
}
  # 年追加の助関数
  # 04_25_date-paste-year-helper-fun.R
this_year <- function(){
  lubridate::today() |>
    lubridate::year()
}
is_future <- function(date){
  lubridate::today() < date
}
  # 年の追加関数
  # 04_26_date-paste-year-fun.R
paste_year <- function(str, past = FALSE){
  str <- stringi::stri_trans_general(str, "fullwidth-halfwidth")
  yr <- this_year()
  date <- lubridate::ymd(paste0(yr, "-", str), quiet = TRUE)
  date <-
    dplyr::if_else(past & is_future(date),   # 目的：過去，変換：未来
      date - lubridate::years(1),            # 1年前
      date                                   # そのまま
    )
  date <-
    dplyr::if_else(!past & !is_future(date), # 目的：未来，変換：過去
      date + lubridate::years(1),            # 1年後
      date                                   # そのまま
    )
  return(date)
}
  # 日付っぽい文字列を日付に変換する関数
  # 04_28_date-date-ish2date-fun.R
date_ish2date <- function(str, past = FALSE){
  str <- stringi::stri_trans_general(str, "fullwidth-halfwidth")
  str <-
    dplyr::if_else(is_jp_date(str),        # 和暦or西暦
      zipangu::convert_jdate(str),         # 和暦を日付に変換
      dplyr::if_else(has_yr(str),          # 西暦，年の有無
        lubridate::ymd(str, quiet = TRUE), # 日付に変換
        paste_year(str, past = past)       # 年を追加して日付に変換
      )
    )
  return(str)
}
  # 西暦年と和暦年を変換する関数
  # 04_32_date-convert-yr-fun.R
convert_yr <- function(str, out_format = "west"){
  no_nen <- stringr::str_which(str, "年", negate = TRUE) # "年"無の序数
  str <-
    paste0(str, "-12-31") |>             # 12月31日として処理
    stringr::str_remove("年") |>         # "年"の除去
    date_ish2date() |>
    format_year(out_format = out_format) # 変換
  nen <- rep("年", times = length(str))
  nen[no_nen] <- ""                      # 年の有無に合わせる
  str <- paste0(str, nen)
  return(str)
}
  # 和暦年と西暦年の書式
format_year <- function(x, out_format = "west"){
  if(out_format == "west"){
    format <- "uuuu"
    locale <- NULL
  }
  if(out_format == "jp"){
    format <- "Gy"
    locale <- "ja_JP@calendar=japanese"
  }
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}
  # 曜日を取り出す関数
  # 04_36_date-extract-wday-fun.R
extract_wday <- function(str){
  str <- stringi::stri_trans_general(str, "fullwidth-halfwidth")
  mn <- "\\d{1,2}[-.,_/月]" # 月
  dy <- "\\d{1,2}日?"       # 日
  dw <- "[月火水木金土日]$" # 曜日
  md <- paste0(mn, dy)
  wd <-
    str |>
    stringr::str_remove(md) |>             # 月日の除去
    stringr::str_remove_all("[\\(\\)]") |> # ()の除去
    stringr::str_extract(dw)               # 曜日の抽出
  return(wd)
}
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
  # 元の書式のまま曜日のみ置換する関数
  # 04_41_date-replace-wday-fun.R
replace_wday <- function(str, wday_orig, wday){
  pattern <- paste0("([\\(（])", wday_orig, "([\\)）])") # 置換前
  replacement <- paste0("\\1", wday, "\\2")              # 置換後
  date <- stringr::str_replace(str, pattern, replacement)
  return(date)
}
  # 日付を指定の書式にする関数
  # 04_42_date-format-date-fun.R
format_date <- function(x, out_format = "west"){
  if(out_format == "west"){ # 西暦
    format <- "uuuu年M月d日(E)"
    locale <- NULL
  }
  if(out_format == "jp"){ # 和暦
    format <- "Gy年M月d日(E)"
    locale <- "ja_JP@calendar=japanese"
  }
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}
  # 各曜日での序数を得る関数
  # 04_45_date-mweek-fun.R
mweek <- function(x){
  (lubridate::mday(x) + 6) %/% 7
}
  # 1年後の同一位置の年月日を取得する関数
  # 04_46_date-same-pos-next-yr-fun.R
same_pos_next_yr <- function(x, out_format = "west"){
  yr <- lubridate::year(x)  # 年
  mn <- lubridate::month(x) # 月
  base <- lubridate::ymd(paste0(yr + 1, "-", mn, "-", 1)) # 1日
  diff <- lubridate::wday(x) - lubridate::wday(base)      # 曜日位置の差
  diff <- dplyr::if_else(diff >= 0, diff, diff + 7)       # 負をは正に変換
  same_pos_day <- base + (mweek(x) - 1) * 7 + diff # 同じ位置
  diff <- dplyr::if_else(diff >= 0, diff, diff + 7) # 負のときは正に変換
  for(i in seq_along(same_pos_day)){
    if(month(same_pos_day[i]) != mn[i]){ # 月が異なるとき
      same_pos_day[i] <- NA # 該当日なし
      warning("No same date as ", x[i], "!")
    }
  }
  same_pos_day <- # 指定の書式に変換
    format_date(same_pos_day, out_format = out_format)
  return(same_pos_day)
}
