  # 文字列の結合
  # 05_01_string-str-c.R
str_neko <- 
  c("吾輩は猫である。", "名前はまだない。", 
    "I am a cat.", "I don't have any name yet.")
str_c(str_neko, "◆") # 各文字列に"◆"を追加、paste0(str_neko, "◆")も同じ

  # collapseで1つの文字列に結合する
str_c(str_neko[1:3], collapse = "◆") # [1:3]：出力を短くするため
  # paste0(str_neko[1:3], collapse = "◆")も同じ

  # 複数の文字列を引数
str_c("吾輩は", "猫である。")  # paste0("吾輩は", "猫である。")も同じ

str_c("吾輩は", "猫である。", sep = "◆")  # 注意：動作が異なる
paste0("吾輩は", "猫である。", sep = "◆")

