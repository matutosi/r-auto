  # 文字列の抽出
  # 03_19_string-str-sub.R
str_123 <- 
  c(paste0(1:9, collapse = ""), 
    "abcdefg", 
    "あいうえおかきくけこ")
str_sub(str_123, start = 2, end = 6) # 全て2-6を抽出
str_sub(str_123, 1:3, 3:5)           # 前から順に1-3，2-4，3-5を抽出

