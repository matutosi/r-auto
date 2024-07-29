  # コメントの抽出
  # 08_27_word-docx-comment.R
comment <- 
  docx_comments(doc_2) |>
  tibble::as_tibble() |>
  print()

