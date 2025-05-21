  # 文字列の結合
  # 05_01_string-str-c.R
str_neko <- 
  c("吾輩は猫である。", "名前はまだない。", 
    "I am a cat.", "I don't have any name yet.")
str_c(str_neko, "◆") # 各文字列に"◆"を追加、paste0()も同じ

  # collapseで1つの文字列に結合する
str_c(str_neko, collapse = "◆")

  # 複数の文字列を引数にとる場合
str_c("吾輩は", "猫である。")

  # sepで結合時に文字を挿入する
  # paste0()と動作が異なるので注意
str_c("吾輩は", "猫である。", sep = "◆")
paste0("吾輩は", "猫である。", sep = "◆")

