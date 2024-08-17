  # エスケープ文字とメタ文字の例
  # 05_06_string-regexp-meta.R
str <- "Hello. "
str_view(str, ".") # 全てにマッチ
str_view(str, "\.") # エラー
str_view(str, "\\.") # .(ドット)にマッチ

