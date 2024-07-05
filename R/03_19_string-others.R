  # stringrのその他の関数
  # 03_19_string-others.R
  # 文字列
str_123
str_neko
  # アルファベットの小文字かひらがなが1つ以上
pattern <- "[a-z]+|[あ-ん]+"

  # マッチ箇所の確認
str_view(str_neko, pattern)

  # マッチ箇所の数
str_count(str_neko, pattern)

  # 1つ目のマッチ箇所の位置(start, end)
str_locate(str_neko, pattern)
  # 全てのマッチ箇所の位置(start, end)
str_locate_all(str_neko, pattern)

  # 字数合わせ
str_pad(1:10, width = 2, side = "left", pad = "0")

  # 切り捨てて省略
str_trunc(str_neko, 7, "right")  # 右を切り捨て
str_trunc(str_neko, 7, "center") # 中央を切り捨て
str_trunc(str_neko, 7, "left")   # 左を切り捨て

  # 分割
(splitted <- str_split(str_neko, "は| "))      # 「は」か半角スペース
str_flatten(str_neko) |> str_split_1("。|\\.") # 「。」か「.」

  # 文字列ベクトルの結合
str_flatten(splitted[[1]], collapse = "◆")

  # マッチ要素のインデックス
str_which(str_neko, "猫|cat")

  # 文字列の長さ(個数)
str_length(str_123)

  # 文字列の表示幅(半角は1，全角は2)
str_width(str_123)

  # 重複除去
(str_number <- letters[c(1:5, 3:7)])
str_unique(str_number)

  # 空白文字の除去
str_trim("    a   b  c  ") # 端のみ除去
str_squish("  a   b  c  ") # 重複も除去

