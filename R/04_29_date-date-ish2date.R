  # 日付っぽい文字列の日付への変換
  # 04_29_date-date-ish2date.R
converted_dates <-
  dates_half |>
  paste(collapse = "間の文字など") |> # 結合
  extract_date_ish() |>               # 抽出
  date_ish2date()                     # 変換
tibble::tibble(dates_half, converted_dates)

