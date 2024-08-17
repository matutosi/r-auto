  # 和暦判別の関数
  # 06_11_date-is-jp-date-fun.R
is_jp_date <- function(str){
  era <- "^([MTSHRＭＴＳＨＲ]|明治|大正|昭和|平成|令和)[\\d元]"
  stringr::str_detect(str, era)
}

