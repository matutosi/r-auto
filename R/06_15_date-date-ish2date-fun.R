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

