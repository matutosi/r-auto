  # 大文字・小文字の区別の有無
  # 03_04_string-regex.R
str <- c("A B C a b c")
pattern <- "A|B"
pattern_ic <- regex(pattern, ignore_case = TRUE)
str_view(str, pattern)    # 大・小の区別あり
str_view(str, pattern_ic) # 大・小の区別なし

