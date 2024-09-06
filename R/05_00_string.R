  # 文字列の結合
  # 05_01_string-str-c.R
str_neko <- 
  c("吾輩は猫である。", "名前はまだない。", 
    "I am a cat.", "I don't have any name yet.")
str_c(str_neko, "◆") # 各文字列に"◆"を追加，paste0(str_neko, "◆")も同じ

  # collapseで1つの文字列に結合する
str_c(str_neko[1:3], collapse = "◆") # [1:3]：出力を短くするため
  # paste0(str_neko[1:3], collapse = "◆")も同じ

  # 複数の文字列を引数
str_c("吾輩は", "猫である。")  # paste0("吾輩は", "猫である。")も同じ

str_c("吾輩は", "猫である。", sep = "◆")  # 注意：動作が異なる
paste0("吾輩は", "猫である。", sep = "◆")

  # 文字列の結合での注意点
  # 05_02_string-str-c-caution.R
str_c(1:5, str_neko, "◆") # エラー：文字列のベクトルの要素数が不一致
str_c(1:4, str_neko, "◆") # ベクトルで指定するときの出力に注意

  # マッチ箇所の明示
  # 05_03_string-str-view.R
str <- c("今日はいい天気です．")
pattern <- "いい天気"
str_view(str, pattern)
c(str, "明日もいい天気かな．明後日はいい天気でしょう．") |>
  str_view(pattern)

  # 大文字・小文字の区別の有無
  # 05_04_string-regex.R
str <- c("A B C a b c")
pattern <- "A|B"
pattern_ic <- regex(pattern, ignore_case = TRUE)
str_view(str, pattern)    # 大・小の区別あり
str_view(str, pattern_ic) # 大・小の区別なし

  # 正規表現ではなく文字そのものでマッチ
  # 05_05_string-fixed.R
str <- c("abc a.c ABC A.C")
pattern <- fixed("a.c")
pattern_ic <- fixed("a.c", ignore_case = TRUE)
str_view(str, pattern)    # 文字列そのもの，大・小の区別あり
str_view(str, pattern_ic) # 文字列そのもの，大・小の区別なし

  # エスケープ文字とメタ文字の例
  # 05_06_string-regexp-meta.R
str <- "Hello. "
str_view(str, ".") # 全てにマッチ
str_view(str, "\.") # エラー
str_view(str, "\\.") # .(ドット)にマッチ

  # 文字列の置換
  # 05_07_string-str-replace.R
str_replace(str_neko, " ", "◆")     # 最初の半角スペースを◆に置換
str_replace_all(str_neko, " ", "◆") # 全部を置換

  # 正規表現を使った文字列の置換
  # 05_08_string-str-replace-regrep.R
pattern <- "[は猫。a]"
str_replace(str_neko, pattern, "◆")
str_replace_all(str_neko, pattern, "◆")

  # 正規表現を使った文字列の削除
  # 05_09_string-str-remove.R
str_remove(str_neko, "[a-z]")     # [a-z]：小文字のアルファベット全部
str_remove_all(str_neko, "[a-z]")
str_remove(str_neko, "[あ-ん]")   # [あ-ん]：ひらがな全部
str_remove_all(str_neko, "[あ-ん]")

  # str_remove()の中身
  # 05_10_string-str-remove-fun.R
str_remove # 関数の中身

  # 文字列の検索
  # 05_11_string-str-brothers.R
str_detect(str_neko, "猫")
str_starts(str_neko, "名前")
str_ends(str_neko, "t.")

  # 文字列の検索
  # 05_12_string-filter-detect.R
mpg <- mpg[,1:5]   # 自動車の燃費データ(dplyrに含まれる)のうち5列だけ
dplyr::filter(mpg, str_detect(model, "pickup")) |> print(n = 3)
dplyr::filter(mpg, str_detect(model, "pickup", negate = TRUE)) |> print(n = 3)

  # 文字列の抽出
  # 05_13_string-str-subset.R
str_stringr <- ls("package:stringr") # パッケージのオブジェクト一覧
length(str_stringr)   # 要素数
str_subset(str_stringr, "^str_s") # 最初がstr_s
str_subset(str_stringr, "t$")     # 末尾がt

  # 文字列の抽出
  # 05_14_string-str-sub.R
(str_123 <- c(paste0(1:9, collapse = ""), "abcdefg", "あいうえおかきくけこ"))
str_sub(str_123, start = 2, end = 6) # 全て2-6を抽出
str_sub(str_123, 1:3, 3:5)           # 前から順に1-3，2-4，3-5を抽出

  # stringrのその他の関数
  # 05_15_string-others.R
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
str_locate_all(str_neko[[1]], pattern)
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

  # diffrのインストールと呼び出し
  # 05_16_string-diffr-install.R
install.packages("diffr")
library(diffr)

  # 文章の比較
  # 05_17_string-compare-diffr.R
f1 <- fs::file_temp()
f2 <- fs::file_temp()
writeLines("日本語での比較実験\n今日は晴れです．\n同じ文章", con = f1)
writeLines("英語での比較の実験\n今日は天気です．\n同じ文章", con = f2)
diffr::diffr(f1, f2, before = fs::path_file(f1), after = fs::path_file(f1))

  # 比較結果のHTMLの設定ファイル
  # 05_18_string-css-path.R
path <- fs::path(fs::path_package("diffr"), 
                 "htmlwidgets/lib/codediff/codediff.css")
shell.exec(path)

