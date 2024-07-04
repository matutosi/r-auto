  # 日付っぽい文字列の抽出
  # 04_17_date-extract-date-ish.R
paste(dates, collapse = "◆") |> #
  print() |>
  extract_date_ish() |>
  length()

