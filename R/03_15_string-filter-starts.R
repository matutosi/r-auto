  # 最初と最後にマッチする文字列の検索
  # 03_15_string-filter-starts.R
dplyr::filter(mpg, str_starts(model, "m")) |> prnt_5()       # mで始まる
dplyr::filter(mpg, str_ends(model, "4wd")) |> prnt_5()       # 4wdで終わる

