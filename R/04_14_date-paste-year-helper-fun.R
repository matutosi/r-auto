  # 年追加の助関数
  # 04_14_date-paste-year-helper-fun.R
this_year <- function(){
  lubridate::today() |>
    lubridate::year()
}
is_future <- function(date){
  lubridate::today() < date
}

