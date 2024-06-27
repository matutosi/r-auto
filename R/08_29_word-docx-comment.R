  # コメントの抽出
  # 08_29_word-docx-comment.R
comment <- 
  docx_comments(doc_2) |>
  tibble::as_tibble() |>
  print()

