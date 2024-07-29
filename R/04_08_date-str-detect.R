  # 日付っぽい文字列の動作確認
  # 04_08_date-str-detect.R
length(dates) # 全体の数
stringr::str_subset(dates, date_ish()) |> length()    # マッチした数
stringr::str_subset(dates, date_ish(), negate = TRUE) # マッチしないもの

