  # 文字列の抽出
  # 02_14_stringr-str-subset.R
str_stringr <- ls("package:stringr") # パッケージのオブジェクト一覧
length(str_stringr)   # 要素数
head(str_stringr, 15) # 最初の15個
str_subset(str_stringr, "^str_s") # 最初がstr_s
str_subset(str_stringr, "t$")     # 末尾がt

