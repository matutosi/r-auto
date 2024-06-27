  # PDFのページ抽出
  # 07_06_pdf-subset.R
pdf_sub <- pdf_subset(pdf_base, pages = c(1,5))
fs::path_file(pdf_sub)

