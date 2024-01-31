  # 正規表現を使った文字列の置換
  # 02_06_stringr-str-replace-regrep.R
pattern <- "[は猫。a]"
str_replace(str_neko, pattern, "◆")
str_replace_all(str_neko, pattern, "◆")

