  # 日付っぽい文字列の抽出
  # 04_17_date-extract-date-ish.R
paste(dates, collapse = "と") |> #
  print() |>
  extract_date_ish() |>
  length()

