  # 正規表現ではなく文字そのものでマッチ
  # 05_05_string-fixed.R
str <- c("abc a.c ABC A.C")
pattern <- fixed("a.c")
pattern_ic <- fixed("a.c", ignore_case = TRUE)
str_view(str, pattern)    # 文字列そのもの、大・小の区別あり
str_view(str, pattern_ic) # 文字列そのもの、大・小の区別なし

