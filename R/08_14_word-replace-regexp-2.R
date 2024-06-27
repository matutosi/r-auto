  # 正規表現による置換(マッチ部分の参照)
  # 08_14_word-replace-regexp-2.R
str <- c(paste0("第", 1:3, "回"), "次第", "回転")
str
stringr::str_replace_all(str, "第(\\d)回", "\\1回目")

