  # stringrのその他の関数
  # 03_19_string-others.R
pattern <- "[a-z]+|[あ-ん]+" # アルファベットの小文字かひらがなが1つ以上

  # マッチ箇所の数
str_count(str_neko, pattern)

  # マッチ箇所の位置(start, end)
str_locate(str_neko, pattern)
str_locate_all(str_neko, pattern)

  # 字数合わせ
str_pad(1:10, width = 2, pad = "0")

  # 切り捨てて省略
str_trunc(str_neko, 7, "right")
str_trunc(str_neko, 7, "center")
str_trunc(str_neko, 7, "left")

  # 分割
(splitted <- str_split(str_neko, "は| ")) # 「は」か半角スペース

  # 文字列ベクトルの結合
str_flatten(splitted[[1]], collapse = "◆")

  # マッチ要素のインデックス
str_which(str_neko, "猫|cat")

  # 文字列の長さ(個数)
str_length(str_123)

  # 文字列の表示幅
str_width(str_123)

  # 重複除去
(str_number <- letters[c(1:5, 3:7)])
str_unique(str_number)

