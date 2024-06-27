  # ワードの内容をテキストとして保存
  # 08_12_word-save-text.R
path_txt <- fs::path_temp("doc.txt")
doc_1 |>
  extract_docx_text(flatten = FALSE) |>
  readr::write_tsv(path_txt, col_names = FALSE)
  # shell.exec(path_txt)

