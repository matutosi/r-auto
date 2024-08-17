  # 文字列の抽出
  # 05_15_string-str-subset.R
str_stringr <- ls("package:stringr") # パッケージのオブジェクト一覧
length(str_stringr)   # 要素数
str_subset(str_stringr, "^str_s") # 最初がstr_s
str_subset(str_stringr, "t$")     # 末尾がt

