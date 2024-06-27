  # 文字列の同一性確認
  # 05_14_command-quotation-identical.R
  # どちらも同じ文字列になる
double_quo <- "\"c:/Program Files/hidemaru/hidemaru.exe\""
single_quo <- '"c:/Program Files/hidemaru/hidemaru.exe"'
identical(double_quo, single_quo) # 同一性の確認

