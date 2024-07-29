  # 最初と最後にマッチする文字列の検索
  # 03_13_string-filter-starts.R
dplyr::filter(mpg, str_starts(model, "m")) |> print(n = 3) # mで始まる
dplyr::filter(mpg, str_ends(model, "4wd")) |> print(n = 3) # 4wdで終わる

