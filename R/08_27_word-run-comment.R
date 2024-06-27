  # コメントの追加
  # 08_27_word-run-comment.R
comment <- run_comment(
  cmt = block_list("これはコメントです．"), 
  run = ftext("コメントが追加された部分の本文です．"),
  author = "コメントの著者",
  date = Sys.Date(),
  initials = "MT"
)
par <- fpar("これはコメントのない部分です．", comment)
doc_2 <- 
  doc_2 |>
  body_add_break() |>
  body_add_fpar(value = par, style = "Normal")

