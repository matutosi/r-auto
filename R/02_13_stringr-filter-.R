  # 正規表現を使った複数文字列の検索
  # 02_13_stringr-filter-.R
str <- "subaru|toyota" # subaruかtoyota
dplyr::filter(mpg, str_detect(manufacturer, str)) |> prnt_5()
  # dplyr::filter(mpg, manufacturer %in% c("subaru", "toyota")) # 上と同じ

