  # 文字列の結合での注意点
  # 03_04_string-str-c-caution.R
str_c(1:5, str_neko, "◆") # エラー：文字列のベクトルの要素数が不一致
str_c(1:4, str_neko, "◆") # ベクトルで指定するときの出力に注意

