  # deeplrのインストールと呼び出し
  # 13_01_translate-install.R
install.packages("deeplr")
library(deeplr)

  # キーの設定
  # 13_02_translate-set-key.R
deepl_key <- "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx:xx"

  # ユーザのドキュメントのディレクトリを開く
  # 13_03_translate-api-key-dir.R
fs::path(Sys.getenv("HOME")) |> # C:/Users/USERNAME/Documents
  shell.exec() # ディレクトリを開く

  # 環境変数の読み込み
  # 13_04_translate-api-sys-getenv.R
deepl_key <- Sys.getenv("DEEPL_API_KEY")
deepl_key

  # 利用可能な言語の一覧
  # 13_05_translate-available-languages.R
available_languages2(deepl_key)

  # 利用量の確認
  # 13_06_translate-usage.R
usage2(deepl_key)

  # 翻訳の例
  # 13_07_translate-translate.R
text <- "This is an example of a translation by DeepL." # もとの文
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)

  # 翻訳用の文章の保存
  # 13_08_translate-writelines.R
path <- fs::path_temp("sample.txt")
head(sentences) # stringrのデータ
paste0(sentences[1:30], collapse = " ") |>
  writeLines(path) # テキストファイルで保存
  # shell.exec(path)

  # 翻訳用の文章の読み込みと分割
  # 13_09_translate-readlines.R
en <- 
  path |>
  readLines() |>
  split_text(max_size_bytes = 500)
en

  # deeplrによる翻訳(for版)
  # 13_10_translate-translated.R
text <- en$segment_text
translated <- list()
len <- length(text)
for(i in 1:len){
  translated[i] <- 
    translate2(text[i], target_lang = "JA", auth_key = deepl_key)
}
translated <- unlist(translated)
translated

  # deeplrによる翻訳(map版)
  # 13_11_translate-translated-safely.R
text <- en$segment_text
translate2_possibly <- purrr::possibly(translate2, otherwise = "!翻訳エラー")
translated <- 
  text |>
  purrr::map_chr(translate2_possibly, target_lang = "JA", auth_key = deepl_key)
translated

  # 1文ごとに分割する関数
  # 13_12_translate-split-sentence-fun.R
split_sentence <- function(x){
  x <- 
    x |>
    stringr::str_replace_all("([。.] *)", "\\1EOS") |> # 区切り文字の挿入
    stringr::str_split("EOS") |>                       # 区切り文字で分割
    unlist()
  return(x[x != ""])                                   # ""(空文字列)を除去
}

  # 1文ごとへの分割
  # 13_13_translate-split-text.R
result <- 
  tibble::tibble(en = split_sentence(text), 
                 jp = split_sentence(translated)) |>
  print()

  # 翻訳結果をExcelに書き込み
  # 13_14_translate-write-xlsx.R
path <- fs::path_temp("sample.xlsx")
openxlsx::write.xlsx(result, path)                        # Excelに書き込み
wb <- openxlsx::loadWorkbook(path)                        # 読み込み
openxlsx::setColWidths(wb, 1, cols = 1:2, width = "auto") # 列幅の変更
openxlsx::saveWorkbook(wb, path, overwrite = TRUE)        # 書き込み
  # shell.exec(path)

  # 中間言語を使った文章の改善
  # 13_15_translate-pimp2.R
text <- "In former times I lived in Kobe" # 変な英語
pimp2(text = text, source_lang = "EN", help_lang = "JA", auth_key = deepl_key)
text <- "私の大きい兄弟は、仕事を教師です。" # 変な日本語
pimp2(text = text, source_lang = "JA", help_lang = "EN", auth_key = deepl_key)

  # textrarのインストールと呼び出し
  # 13_16_translate-textrar-install.R
install.packages("textrar")
library(textrar)

  # TexTraの認証情報の取得
  # 13_17_translate-textra-auth.R
textra_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # APIキー
textra_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"        # API secret
name <- "LOGIN_ID"                                         # ログインID
params <- gen_params(key = textra_key,                     # 認証情報
                     secret = textra_secret, name = name)

  # モデルによる翻訳の違い
  # 13_18_translate-textra-models.R
sample <- "I am a cat. I have no name. It is fine today."
textra(sample, params = params)                     # 新エンジン(既定値)
textra(sample, params = params, model = "patentNT") # 特許
textra(sample, params = params, model = "seikatsu") # 日常会話

