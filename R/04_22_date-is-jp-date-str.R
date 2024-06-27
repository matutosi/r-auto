  # 和暦と西暦の判別
  # 04_22_date-is-jp-date-str.R
dates_half <- stringi::stri_trans_general(dates, "fullwidth-halfwidth")
converted <-
  dplyr::if_else(is_jp_date(dates_half), # 和暦と西暦の判別
             zipangu::convert_jdate(dates_half), # 和暦
             ymd(dates_half, quiet = TRUE)) |>   # 西暦
  rlang::set_names(dates_half) |> # 名前付きにする
  as.list() # リストに変換
str(converted[1:20])

