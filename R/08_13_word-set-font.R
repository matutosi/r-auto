  # フォントサイズとフォントタイプを変更
  # 08_13_word-set-font.R
doc_1 <- 
  doc_1 |>
  docx_set_paragraph_style(style_id = "Normal", style_name = "Normal",
    fp_t = fp_text(font.size = 18, font = "Yu Gothic")) |>
  docx_set_paragraph_style(style_id = "Titre1", style_name = "heading 1",
    fp_t = fp_text(font.size = 40, font = "MS Gothic")) |>
  docx_set_paragraph_style(style_id = "Titre2", style_name = "heading 2",
    fp_t = fp_text(font.size = 30, font = "MS Mincho")) |>
  docx_set_paragraph_style(style_id = "Titre3", style_name = "heading 3",
    fp_t = fp_text(font.size = 20, font = "UD デジタル 教科書体 NK-R"))
print(x = doc_1, target = path_doc_1)

