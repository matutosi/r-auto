  # 日付の1年後の同じ位置への更新
  # 08_23_word-dates-next-yr.R
dates_next_yr <- 
  dates_before |>
  lubridate::ymd() |>
  same_pos_next_yr()
tibble::tibble(dates_before, dates_next_yr) # 置換文字列の一覧
doc_1 <- 
  purrr::reduce2(.x = dates_before, .y = dates_next_yr, 
                 .f = body_replace_all_text, .init = doc_1, fixed = TRUE)

