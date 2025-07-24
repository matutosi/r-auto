  # 1文ごとへの分割
  # 13_13_translate-split-text.R
result <- 
  tibble::tibble(en = split_sentence(text), 
                 jp = split_sentence(translated)) |>
  print()

