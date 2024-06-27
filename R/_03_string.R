  # tidyverseのインストール
  # 03_01_string-install.R
install.packages("tidyverse") # stringrを含むパッケージ群をインストール
  # install.packages("stringr") # 単独でのインストール

  # tidyverseの呼び出し
  # 03_02_string-library.R
library(tidyverse)   # tidyverseを呼び出し(tidyverseはstringrを含む)
  # library(stringr) # 単独で呼び出すとき

  # 文字列の結合
  # 03_03_string-str-c.R
str_neko <- 
  c("吾輩は猫である。", "名前はまだない。", 
    "I am a cat.", "I don't have any name yet.")
str_c(str_neko, "◆") # 各文字列に"◆"を追加
  # paste0(str_neko, "◆")でも同じ

  # collapseで1つの文字列に結合する
str_c(str_neko[1:3], collapse = "◆") # [1:3]：出力を短くするため
  # paste0(str_neko[1:3], collapse = "◆")も同じ

  # 複数の文字列を引数にしたとき
str_c("吾輩は", "猫である。")
  # paste0("吾輩は", "猫である。")も同じ

  # 注意：動作が異なる
str_c("吾輩は", "猫である。", sep = "◆")
paste0("吾輩は", "猫である。", sep = "◆")

  # 文字列の結合での注意点
  # 03_04_string-str-c-caution.R
str_c(1:5, str_neko, "◆") # エラー：文字列のベクトルの要素数が不一致
str_c(1:4, str_neko, "◆") # ベクトルで指定するときの出力に注意

  # マッチ箇所の明示
  # 03_05_str-view.R
str <- c("今日はいい天気です．")
pattern <- "いい天気"
str_view(str, pattern)
c(str, "明日もいい天気かな．明後日はいい天気でしょう．") |>
  str_view(pattern)

  # ```{r string-regex, subject = 'regxs()', caption = '大文字・小文字の区別の有無'}
  # 03_06_string-regex.R
str <- c("A B C a b c")
pattern <- "A|B"
pattern_ic <- regex(pattern, ignore_case = TRUE)
str_view(str, pattern)    # 大・小の区別あり
str_view(str, pattern_ic) # 大・小の区別なし

  # 正規表現ではなく文字そのものでマッチ
  # 03_07_string-fixed.R
str <- c("abc a.c ABC A.C")
pattern <- fixed("a.c")
pattern_ic <- fixed("a.c", ignore_case = TRUE)
str_view(str, pattern)    # 文字列そのもの，大・小の区別あり
str_view(str, pattern_ic) # 文字列そのもの，大・小の区別なし

  # 文字列の置換
  # 03_08_string-str-replace.R
str_replace(str_neko, " ", "◆")     # 最初の半角スペースを◆に置換
str_replace_all(str_neko, " ", "◆") # 全部を置換

  # 正規表現を使った文字列の置換
  # 03_09_string-str-replace-regrep.R
pattern <- "[は猫。a]"
str_replace(str_neko, pattern, "◆")
str_replace_all(str_neko, pattern, "◆")

  # 正規表現を使った文字列の削除
  # 03_10_string-str-remove.R
str_remove(str_neko, "[a-z]")     # [a-z]：小文字のアルファベット全部
str_remove_all(str_neko, "[a-z]")
str_remove(str_neko, "[あ-ん]")   # [あ-ん]：ひらがな全部
str_remove_all(str_neko, "[あ-ん]")

  # str_remove()の中身
  # 03_11_string-str-remove-fun.R
str_remove # 関数の中身

  # 文字列の検索
  # 03_12_string-str-brothers.R
str_detect(str_neko, "猫")
str_starts(str_neko, "名前")
str_ends(str_neko, "t.")

  # データフレームの表示を短縮する関数
  # 03_13_string-filter-fun.R
  # 表示を短縮するため
prnt_5 <- function(df){
  dplyr::distinct(df) |> # 重複を除く
  print(n = 5)            # 最初の5行のみ
}

  # 文字列の検索
  # 03_14_string-filter-detect.R
  # library(tidyverse) # tidyverseを呼び出していないとき
(mpg <- mpg[,1:5]) # 自動車の燃費データ(dplyrに含まれる)のうち5列だけ
dplyr::filter(mpg, str_detect(model, "pickup")) |> prnt_5()  # pickupを含む
dplyr::filter(mpg, !str_detect(model, "pickup")) |> prnt_5() # !で否定

  # 最初と最後にマッチする文字列の検索
  # 03_15_string-filter-starts.R
dplyr::filter(mpg, str_starts(model, "m")) |> prnt_5()       # mで始まる
dplyr::filter(mpg, str_ends(model, "4wd")) |> prnt_5()       # 4wdで終わる

  # 正規表現を使った複数文字列の検索
  # 03_16_string-filter-.R
str <- "subaru|toyota" # subaruかtoyota
dplyr::filter(mpg, str_detect(manufacturer, str)) |> prnt_5()
  # dplyr::filter(mpg, manufacturer %in% c("subaru", "toyota")) # 上と同じ

  # 文字列の抽出
  # 03_17_string-str-subset.R
str_stringr <- ls("package:stringr") # パッケージのオブジェクト一覧
length(str_stringr)   # 要素数
head(str_stringr, 15) # 最初の15個
str_subset(str_stringr, "^str_s") # 最初がstr_s
str_subset(str_stringr, "t$")     # 末尾がt

  # 文字列の抽出
  # 03_18_string-str-sub.R
str_123 <- 
  c(paste0(1:9, collapse = ""), 
    "abcdefg", 
    "あいうえおかきくけこ")
str_sub(str_123, start = 2, end = 6) # 全て2-6を抽出
str_sub(str_123, 1:3, 3:5)           # 前から順に1-3，2-4，3-5を抽出

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

