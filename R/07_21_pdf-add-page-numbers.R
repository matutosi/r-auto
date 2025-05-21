  # ページ番号の重ね合わせ
  # 07_21_pdf-add-page-numbers.R
pdf_paged <- pdf_base |>
  add_page_numbers(size = 200, y_pos = 90, colour = "#00FFFF", 
                   backside = TRUE)

