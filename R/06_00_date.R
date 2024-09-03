  # zipanguとcalendRのインストールと呼び出し
  # 06_01_date-install.R
install.packages("zipangu")
install.packages("calendR")
library(zipangu)
library(calendR)

  # 文字列を日付データに変換
  # 06_02_date-ymd.R
c("2024年4月10日", "2024-4-10", "20240410", "2024/4/10(水)") |> ymd()

  # 実行時の日付
  # 06_03_date-today.R
today() # 実行日によって結果は異なる

  # 日付を操作する関数
  # 06_04_date-months-years.R
day_base <- ymd("2024-03-31")
day_base + months(1:4) # months()はbaseの関数
day_base + years(1:4) # 1-4年後まで

  # 曜日を求める
  # 06_05_date-wday.R
wday(day_base) # week of the day
wday(day_base, label = TRUE)

  # 日付っぽい文字列の正規表現を返す関数
  # 06_06_date-date-ish-fun.R
date_ish <- function(){
  era <- "([MTSHRＭＴＳＨＲ]|明治|大正|昭和|平成|令和)?" # 元号
  yr <- "[\\d元]{0,4}[-－.．_＿/／年]?"                  # 年(区切り非必須)
  mn <- "\\d{1,2}[-－.．_＿/／月]"                       # 月(区切り必須)
  dy <- "\\d{1,2}日?"                                    # 日(区切り非必須)
  dw <- "([\\(（][月火水木金土日祝]+[\\)）])?"           # 曜日(非必須)
  mn_dy <- "(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])"     # 月日
  yr_4 <-  "(19|20)?[0-9]{2}"                            # 2桁か4桁の年
  p_1 <- paste0(era, yr, mn, dy, dw)
  p_2 <- paste0(      mn_dy)                             # 数字のみの月日
  p_3 <- paste0(yr_4, mn_dy)                             # 数字のみの年月日
  pattern <- paste(p_1, p_2, p_3, sep = "|")
  return(pattern)
}

  # 日付っぽい文字列
  # 06_07_date-for-check.R
dates <- c("令和6年5月26日", "令和6.5.26", "R6.05.26",
            "2024年7月23日",  "2024-7-23", "24.7.23",
            "20240723", "240723", "11.27", "1127")
dates_half <- c(dates, paste0(dates, "(日)"))
dates_full <- stringi::stri_trans_general(dates_half, "halfwidth-fullwidth")
dates <- c(dates_half, dates_full)
dates[c(1:10, 11, 21, 25, 27, 35)] # 代表的なもののみ表示

  # 日付っぽい文字列の動作確認
  # 06_08_date-str-detect.R
length(dates) # 全体の数
stringr::str_subset(dates, date_ish()) |> length()    # マッチした数
stringr::str_subset(dates, date_ish(), negate = TRUE) # マッチしないもの

  # 日付っぽい文字列を抽出する関数
  # 06_09_date-extract-date-ish-fun.R
extract_date_ish <- function(str, simplify = FALSE){
  pattern <- date_ish()
  res <-
    stringr::str_extract_all(str, pattern = pattern, simplify = simplify)
  if(length(res) == 1){
    res <- res[[1]]
  }
  return(res)
}

  # 日付っぽい文字列の抽出
  # 06_10_date-extract-date-ish.R
paste(dates, collapse = "◆") |> #
  extract_date_ish() |>
  length()

  # 和暦判別の関数
  # 06_11_date-is-jp-date-fun.R
is_jp_date <- function(str){
  era <- "^([MTSHRＭＴＳＨＲ]|明治|大正|昭和|平成|令和)[\\d元]"
  stringr::str_detect(str, era)
}

  # 年の有無の判別関数
  # 06_12_date-has-yr-fun.R
has_yr <- function(str){
  dw <- "\\([月火水木金土日祝]+\\)$"
  str <-
    str |>
    stringi::stri_trans_general("fullwidth-halfwidth") |>   # 半角に変換
    stringr::str_remove(dw) |>                              # 曜日を削除
    stringr::str_remove("日$")                              # 最後の"日"を削除
  res <-
    dplyr::if_else(stringr::str_count(str, "[^0-9]") == 0,  # [^0-9]：数字以外
      dplyr::if_else(stringr::str_count(str, "[0-9]") >= 6, # 数字：桁数で判別
              TRUE,                                         # 6桁以上
              FALSE),                                       # 5桁以下
      dplyr::if_else(stringr::str_count(str, "[^0-9]") >= 2, # 数字以外あり
              TRUE,                           # 区切り文字が2つ以上：年あり
              FALSE)                          # 区切り文字が1つ：年なし
    )
  return(res)
}

  # 年追加の助関数
  # 06_13_date-paste-year-helper-fun.R
this_year <- function(){
  lubridate::today() |>
    lubridate::year()
}
is_future <- function(date){
  lubridate::today() < date
}

  # 年の追加関数
  # 06_14_date-paste-year-fun.R
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
  # 06_15_date-date-ish2date-fun.R
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

  # 日付っぽい文字列の日付への変換
  # 06_16_date-date-ish2date.R
converted_dates <-
  dates_half |>
  paste(collapse = "間の文字など") |> # 結合
  extract_date_ish() |>               # 抽出
  date_ish2date()                     # 変換
tibble::tibble(dates_half, converted_dates)

  # 和暦から西暦への変換
  # 06_17_date-zipangu.R
zipangu::convert_jdate(c("Ｈ29,1,1", "R6/10/30"))
zipangu::convert_jyear(c("S63", "平成４年５月１日"))

  # 西暦から和暦への変換
  # 06_18_date-stri-datetime-format.R
c("2019-04-30", "2019-05-01") |>
  ymd() |>
  stringi::stri_datetime_format(format = "Gy年M月d日(E)",
                                locale = "ja_JP@calendar=japanese")

  # 西暦年と和暦年を変換する関数
  # 06_19_date-convert-yr-fun.R
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
format_year <- function(x, out_format = "west"){
  if(out_format == "west"){ format <- "uuuu" } # 西暦
  if(out_format == "jp")  { format <- "Gy" }   # 和暦
  locale <- "ja_JP@calendar=japanese"
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}

  # 西暦年と和暦年の変換
  # 06_20_date-convert-yr.R
str <- c("昭和50", "1992", "令和元年", "2024年")
convert_yr(str, out_format = "jp")
convert_yr(str, out_format = "west")

  # 和暦・西暦の一括変換
  # 06_21_date-convert-yr-replace.R
yr_west <- paste0(as.character(1950:2024), "年")
yr_jp <- convert_yr(yr_west, out_format = "jp")
sentence <- "昭和48年生まれは，平成30年で45歳，令和5年で50歳です．
             昭和50年生まれは，平成30年で43歳，令和5年で48歳です．" |>
  stringr::str_remove_all(" ") # 空白を削除
  # 置換するとき
pattern <- yr_west
names(pattern) <- yr_jp # ベクトルに名前を付ける
stringr::str_replace_all(sentence, pattern) |> cat()
  # 併記するとき
pattern <- paste0(stringr::str_remove(yr_west, "年"), "(", yr_jp, ")")
names(pattern) <- yr_jp # ベクトルに名前を付ける
stringr::str_replace_all(sentence, pattern) |>
  cat()

  # ワードでの一括変換(疑似コード)
  # 06_22_date-convert-yr-replace-word.R
path <- "DIRECTORY/word.docx"
doc <- officer::read_docx(path)
doc <- purrr::reduce2(.x = yr_jp, .y = yr_west, 
                      .f = officer::body_replace_all_text, .init = doc)

  # 曜日を取り出す関数
  # 06_23_date-extract-wday-fun.R
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

  # 曜日の取り出し
  # 06_24_date-extract-wday.R
wd <- extract_wday(dates)
names(wd) <- dates
wd[!is.na(wd)] |> # NA以外
  as.list() |>    # リストに変換
  str()           # 構造を表示

  # 日付と曜日との整合性を確認する関数
  # 06_25_date-is-correct-wday-fun.R
is_correct_wday <- function(str){
  wday_orig <- extract_wday(str) # 元の曜日
  date <- date_ish2date(str)     # 日付
  wday <-                        # 日付にあう曜日
    date |>
    lubridate::wday(label = TRUE, locale = "ja_JP.UTF-8") |>
    as.character()
  is_correct <- (wday == wday_orig) # 正しいか
  res <- list(is_correct = is_correct, date_orig = str,
              wday_orig = wday_orig, date = date, wday = wday)
  return(res)
}

  # 日付と曜日との整合性の確認
  # 06_26_date-is-correct-wday.R
is_correct_wday(dates) |>
  tibble::as_tibble() |>
  na.omit() |>
  print(n = 20)

  # 元の書式のまま曜日のみ置換する関数
  # 06_27_date-replace-wday-fun.R
replace_wday <- function(str, wday_orig, wday){
  pattern <- paste0("([\\(（])", wday_orig, "([\\)）])") # 置換前
  replacement <- paste0("\\1", wday, "\\2")              # 置換後
  date <- stringr::str_replace(str, pattern, replacement)
  return(date)
}

  # 日付を指定の書式にする関数
  # 06_28_date-format-date-fun.R
format_date <- function(x, out_format = "west"){
  if(out_format == "west"){ format <- "uuuu年M月d日(E)" } # 西暦
  if(out_format == "jp")  { format <- "Gy年M月d日(E)" }   # 和暦
  locale <- "ja_JP@calendar=japanese"
  x <- stringi::stri_datetime_format(x, format = format, locale = locale)
  return(x)
}

  # 曜日を修正する関数
  # 06_29_date-update-wday-fun.R
update_wday <- function(str, out_format = "west"){
  res <- is_correct_wday(str)   # 曜日が正しいか判定
  if(out_format == "original"){ # 元の書式
    date <- replace_wday(str, res$wday_orig, res$wday)
  }else{ # 和暦か西暦
    date <- format_date(res$date, out_format = out_format)
  }
  return(date)
}

  # 曜日の修正
  # 06_30_date-update-wday.R
tibble::tibble(west   = update_wday(dates, out_format = "west"),
               jp     = update_wday(dates, out_format = "jp"),
               update = update_wday(dates,out_format = "original"),
               orig   = dates) |>
  print(n = 20)

  # 各曜日での序数を得る関数
  # 06_31_date-mweek-fun.R
mweek <- function(x){
  (lubridate::mday(x) + 6) %/% 7
}

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

  # 1年後の同一位置の年月日の取得
  # 06_33_date-same-pos-next-yr.R
x <- ymd("2024-05-01")
days <- x + 0:30
days
days_next_yr <- same_pos_next_yr(days)
days_next_yr

  # カレンダーでの確認
  # 06_34_date-gen-cal.R
weeknames <-  c("M", "T", "W", "T", "F", "S", "S")
title_1 <- paste0(year(x)    , "-" , month(x))
title_2 <- paste0(year(x) + 1, "-" , month(x))
  # カレンダーでの表示
calendR::calendR(year(x)    , month(x),
  title = title_1, start = "M", weeknames = weeknames, papersize = "A6")
calendR::calendR(year(x) + 1, month(x),
  title = title_2, start = "M", weeknames = weeknames, papersize = "A6")

  # 1年後の日付への更新
  # 06_35_date-same-pos-next-yr-example.R
sentence <- "大学祭「よつば祭」は，2024年10月26日と10月27日に開催します．"
days_this_yr <- extract_date_ish(sentence)
days_next_yr <-
  days_this_yr |>
  date_ish2date() |>
  same_pos_next_yr(out_format = "west") |>
  rlang::set_names(days_this_yr) # 名前が置換前，値が置換後
sentence |>
  stringr::str_replace_all(days_next_yr)

