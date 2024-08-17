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

