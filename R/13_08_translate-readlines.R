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

