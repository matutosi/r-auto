  # PDFの回転
  # 07_12_pdf-rotate.R
pdf_rtt <- pdf_rotate_pages(pdf_com, pages = c(1,3))
fs::path_file(pdf_rtt) # ファイル名のみ

