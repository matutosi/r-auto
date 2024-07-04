  # deeplrのインストールと呼び出し
  # 13_01_translate-install.R
install.packages("deeplr")
library(deeplr)

  # キーの設定
  # 13_02_translate-set-key.R
deepl_key <- "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:xx"

  # ユーザのドキュメントのディレクトリを開く
  # 13_03_translate-api-key-dir.R
fs::path(Sys.getenv("HOME")) |> # c:\Users\USERNAME\Documents
  shell.exec() # ディレクトリを開く

  # 環境変数の読み込み
  # 13_04_translate-api-sys-getenv.R
deepl_key <- Sys.getenv("DEEPL_API_KEY")
deepl_key

  # 利用可能な言語の一覧
  # 13_05_translate-available-languages.R
langs <- available_languages2(deepl_key)
head(langs, 14)
 ## # A tibble: 29 × 2
 ##    language name      
 ##    <chr>    <chr>     
 ##  1 BG       Bulgarian 
 ##  2 CS       Czech     
 ##  3 DA       Danish    
 ##  4 DE       German    
 ##  5 EL       Greek     
 ##  6 EN       English   
 ##  7 ES       Spanish   
 ##  8 ET       Estonian  
 ##  9 FI       Finnish   
 ## 10 FR       French    
 ## 11 HU       Hungarian 
 ## 12 ID       Indonesian
 ## 13 IT       Italian   
 ## 14 JA       Japanese  

  # 翻訳の例
  # 13_06_translate-translate.R
text <- "This is an example of a translation by DeepL."
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)
 ## [1] "これはDeepLによる翻訳の例である。"
text <- "I am a cat. I have no name. It is fine today." # 夏目漱石の「吾輩は猫である」
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)
 ## 私は猫だ。名前はない。今日も元気だ。

  # 翻訳用の文書の保存
  # 13_07_translate-weitelines.R
path <- fs::path_temp("sample.txt")
head(sentences) # stringrのデータ
paste0(sentences[1:30], collapse = " ") |>
  writeLines(path) # テキストファイルで保存
  # shell.exec(path)

  # 翻訳用の文書の読み込みと分割
  # 13_08_translate-readlines.R
en <- 
  path |>
  readLines() |>
  split_text(max_size_bytes = 500)
en
 ## # A tibble: 3 × 3
 ##   text_id segment_id segment_text
 ##     <int>      <int> <chr>
 ## 1       1          1 The birch canoe slid on the smooth planks.…
 ## 2       1          2 The source of the huge river is the clear …
 ## 3       1          3 Two blue fish swam in the tank. Her purse …

  # deeplrによる翻訳(for版)
  # 13_09_translate-translated.R
text <- en$segment_text
translated <- list()
len <- length(text)
for(i in 1:len){
  translated[i] <- 
    translate2(text[i], target_lang = "JA", auth_key = deepl_key)
}
translated <- unlist(translated)
translated
 ## [1] "白樺のカヌーは滑らかな板の上を滑った。紺色の背景にシートを..."
 ## [2] "大河の源は清流。ボールをまっすぐ蹴り、フォロースルー。女性..."
 ## [3] "水槽には2匹の青い魚が泳いでいた。彼女の財布は無駄なゴミで..."

  # deeplrによる翻訳(map版)
  # 13_10_translate-translated-safely.R
text <- en$segment_text
translate2_possibly <- purrr::possibly(translate2, otherwise = "!翻訳エラー")
translated <- 
  text |>
  purrr::map_chr(translate2_possibly, target_lang = "JA", auth_key = deepl_key)
translated
 ## (2番目がエラーのときの結果の例)
 ## [1] "白樺のカヌーは滑らかな板の上を滑った。紺色の背景にシートを..."
 ## [2] "!翻訳エラー"
 ## [3] "水槽には2匹の青い魚が泳いでいた。彼女の財布は無駄なゴミで..."

  # 文に分割する関数
  # 13_11_translate-split-sentence-fun.R
split_sentence <- function(x){
  x <- 
    x |>
    stringr::str_replace_all("([。.] *)", "\\1EOS") |> # 区切り文字の挿入
    stringr::str_split("EOS") |>                       # 区切り文字で分割
    unlist()
  return(x[x != ""])                                   # ""(空文字列)を除去
}

  # 文への分割
  # 13_12_translate-split-text.R
result <- 
  tibble::tibble(en = split_sentence(text), 
                 jp = split_sentence(translated)) |>
  print()
 ## # A tibble: 30 × 2
 ##    en                                        jp
 ##    <chr>                                     <chr>
 ##  1 "The birch canoe slid on the smoo..."  "白樺のカヌーは滑らかな板の上..."
 ##  2 "Glue the sheet to the dark blue ..."  "紺色の背景にシートを糊付けする。"
 ##  3 "It's easy to tell the depth of a..."  "井戸の深さを知るのは簡単だ。"
 ##  4 "These days a chicken leg is a ra..."  "最近、鶏のモモ肉は珍しい料理だ。"
 ##  5 "Rice is often served in round bo..."  "ご飯は丸い茶碗に盛られること..."
 ##  6 "The juice of lemons makes fine p..."  "レモンの果汁はいいパンチを作る。"
 ##  7 "The box was thrown beside the pa..."  "箱は駐車中のトラックの横に投げら"
 ##  8 "The hogs were fed chopped corn a..."  "豚には刻んだトウモロコシと生..."
 ##  9 "Four hours of steady work faced ..."  "4時間の地道な作業が待っていた。"
 ## 10 "A large size in stockings is har..."  "ストッキングの大きいサイズはな..."
 ## # ℹ 20 more rows

  # 翻訳結果をエクセルに書き込み
  # 13_13_translate-write-xlsx.R
path <- fs::path_temp("sample.xlsx")
openxlsx::write.xlsx(result, path)                        # エクセルに書き込み
wb <- openxlsx::loadWorkbook(path)                        # 読み込み
openxlsx::setColWidths(wb, 1, cols = 1:2, width = "auto") # 列幅の変更
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)        # 書き込み
  # shell.exec(path)

  # 中間言語を使った文章の改善
  # 13_14_translate-pimp2.R
text <- "In former times I lived in Kobe"
pimp2(text = text, source_lang = "EN", help_lang = "JA", auth_key = deepl_key)
text <- "私の大きい兄弟は，仕事を教師です．" # 変な日本語
pimp2(text = text, source_lang = "JA", help_lang = "EN", auth_key = deepl_key)

  # 利用量の確認
  # 13_15_translate-usage.R
usage2(deepl_key)

  # textrarのインストールと呼び出し
  # 13_16_translate-textrar-install.R
install.packages("textrar")
library(textrar)

  # TexTraの認証情報の取得
  # 13_17_textra-auth.R
  # 環境変数に保存したとき
  # textra_key <- Sys.getenv("TEXTRA_KEY")
  # textra_secret <- Sys.getenv("TEXTRA_SECRET")
textra_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # APIキー
textra_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"        # API secret
name <- "LOGIN_ID"                                         # ログインID
params <- gen_params(key = textra_key,                     # 認証情報
                     secret = textra_secret, name = name)

  # モデルによる翻訳の違い
  # 13_18_translate-textra-models.R
sample <- "I am a cat. I have no name. It is fine today."
textra(sample, params = params)                     # 新エンジン(既定値)
 ## [1] "私は猫です。 名前はありません。 今日はいい天気です。"
textra(sample, params = params, model = "patentNT") # 特許
 ## [1] "私は猫であり、名前はない。今日は良い。"
textra(sample, params = params, model = "seikatsu") # 日常会話
 ## [1] "私は猫を飼っています。名前は書いてありません。今日はお天気もいいです。"

  # TexTraによる翻訳
  # 13_19_translate-textrar.R
models <- c("transLM", "patentNT", "seikatsu")
text <- split_sentence(text)
len <- length(text)
translated_models <- list()
for(model in models){
  for(i in 1:len){
    translated_models[[model]][i] <- textra(text[i], params, model = model)
  }
}
result2 <- tibble::as_tibble(translated_models)
result <- dplyr::bind_cols(result, result2) |>
  print()

  # 翻訳結果のエクセルへの書き込み
  # 13_20_tidy.R
path <- fs::path_temp("sample.xlsx")
openxlsx::write.xlsx(result, path) # エクセルに一旦書き込み
wb <- openxlsx::loadWorkbook(path) # 読み込み
openxlsx::setColWidths(wb, 1, cols = 1:5, width = 40) # 列幅の変更
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)  # 書き込み
  # shell.exec(path)

