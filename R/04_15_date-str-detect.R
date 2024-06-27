  # 日付っぽい文字列の動作確認
  # 04_15_date-str-detect.R
  # stringr::str_view(dates, date_ish()) |> print(n = Inf)
length(dates) # 全体の数
stringr::str_detect(dates, date_ish()) |> sum() # マッチした数
str_view(dates, date_ish()) |>
  print(n = 10)
stringr::str_subset(dates, date_ish(), negate = TRUE) # マッチせず

