  # 翻訳用の文章の保存
  # 13_08_translate-writelines.R
path <- fs::path_temp("sample.txt")
head(sentences) # stringrのデータ
paste0(sentences[1:30], collapse = " ") |>
  writeLines(path) # テキストファイルで保存
  # shell.exec(path)

