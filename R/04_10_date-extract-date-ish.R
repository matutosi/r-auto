  # 日付っぽい文字列の抽出
  # 04_10_date-extract-date-ish.R
paste(dates, collapse = "◆") |> #
  extract_date_ish() |>
  length()

