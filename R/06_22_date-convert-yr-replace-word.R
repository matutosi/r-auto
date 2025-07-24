  # Wordでの一括変換(疑似コード)
  # 06_22_date-convert-yr-replace-word.R
path_in <- "DIRECTORY/word.docx"
path_out <- "DIRECTORY/word_replaced.docx"
doc <- officer::read_docx(path_in)
doc <- purrr::reduce2(.x = yr_jp, .y = yr_west, 
                      .f = officer::body_replace_all_text, .init = doc)
print(doc, path_out)

