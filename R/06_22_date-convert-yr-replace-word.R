  # ワードでの一括変換(疑似コード)
  # 06_22_date-convert-yr-replace-word.R
path <- "DIRECTORY/word.docx"
doc <- officer::read_docx(path)
doc <- purrr::reduce2(.x = yr_jp, .y = yr_west, 
                      .f = officer::body_replace_all_text, .init = doc)

