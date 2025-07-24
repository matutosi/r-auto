  # 年追加の補助関数(`this_year()`と`is_future()`)
  # 06_13_date-paste-year-helper-fun.R
this_year <- function(){
  lubridate::today() |>
    lubridate::year()
}
is_future <- function(date){
  lubridate::today() < date
}

