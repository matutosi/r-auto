  # PDFの分割
  # 07_04_pdf-split.R
pdf_spl <- 
  pdf_split(pdf_base)
fs::path_file(pdf_spl) # ファイル名のみ

