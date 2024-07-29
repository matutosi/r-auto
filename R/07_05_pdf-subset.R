  # PDFのページ抽出
  # 07_05_pdf-subset.R
pdf_sub <- pdf_subset(pdf_base, pages = c(1,5))
fs::path_file(pdf_sub)

