  # 年の追加関数
  # 04_15_date-paste-year-fun.R
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

