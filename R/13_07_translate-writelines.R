  # 翻訳用の文書の保存
  # 13_07_translate-writelines.R
path <- fs::path_temp("sample.txt")
head(sentences) # stringrのデータ
paste0(sentences[1:30], collapse = " ") |>
  writeLines(path) # テキストファイルで保存
  # shell.exec(path)

