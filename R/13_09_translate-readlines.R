  # 翻訳用の文章の読み込みと分割
  # 13_09_translate-readlines.R
en <- 
  path |>
  readLines() |>
  split_text(max_size_bytes = 500)
en

