  # 正規表現を使った複数文字列の検索
  # 03_14_string-filter-in.R
str <- "subaru|toyota" # subaruかtoyota
dplyr::filter(mpg, str_detect(manufacturer, str)) |> print(n = 5)
  # dplyr::filter(mpg, manufacturer %in% c("subaru", "toyota")) # 上と同じ

