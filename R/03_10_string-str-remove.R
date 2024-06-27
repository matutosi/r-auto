  # 正規表現を使った文字列の削除
  # 03_10_string-str-remove.R
str_remove(str_neko, "[a-z]")     # [a-z]：小文字のアルファベット全部
str_remove_all(str_neko, "[a-z]")
str_remove(str_neko, "[あ-ん]")   # [あ-ん]：ひらがな全部
str_remove_all(str_neko, "[あ-ん]")

