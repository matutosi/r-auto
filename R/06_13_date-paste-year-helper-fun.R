  # 年追加の助関数
  # 06_13_date-paste-year-helper-fun.R
this_year <- function(){
  lubridate::today() |>
    lubridate::year()
}
is_future <- function(date){
  lubridate::today() < date
}

