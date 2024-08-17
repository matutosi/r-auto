  # 曜日の取り出し
  # 06_24_date-extract-wday.R
wd <- extract_wday(dates)
names(wd) <- dates
wd[!is.na(wd)] |> # NA以外
  as.list() |>    # リストに変換
  str()           # 構造を表示

