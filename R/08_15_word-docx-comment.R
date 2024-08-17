  # コメントの抽出
  # 08_15_word-docx-comment.R
comment <- 
  docx_comments(doc_1) |>
  tibble::as_tibble() |>
  print()

