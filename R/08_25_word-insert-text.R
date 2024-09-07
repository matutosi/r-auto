  # 文字列と画像をまとめて入力
  # 08_25_word-insert-text.R
text <- c("文章1", "文章2", "文章3")
images <- imgs # extract_docx_imgs()で抽出した画像
new_doc <- read_docx() |>
  insert_texts(text) |>
  insert_images(images)
print(new_doc, fs::path_home("new.docx"))

