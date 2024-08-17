  # 文字列をまとめて入力(疑似コード)
  # 08_25_word-insert-text.R
text <- c("文章1", "文章2", "文章3")
images <- c("a.jpg", "b.png")
new_doc <- read_docx() |>
  insert_texts(text) |>
  insert_images(images)
print(new_doc, fs::path_home("new.docx"))

