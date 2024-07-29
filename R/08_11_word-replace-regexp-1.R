  # 正規表現による置換
  # 08_11_word-replace-regexp-1.R
doc_1 |> # 置換前
  extract_docx_text(heading = FALSE) |>
  `[`(_, 1:5)
doc_1 <- # 正規表現による置換
  body_replace_all_text(doc_1, "オラウ.タン", "オランウータン")
doc_1 |> # 置換後
  extract_docx_text(heading = FALSE) |>
  `[`(_, 1:5)

