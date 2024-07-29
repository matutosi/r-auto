  # PDFのページ順序の入れ替え
  # 07_06_pdf-subset-reverse.R
len <- pdf_length(pdf_base)
pdf_reverse <- pdf_subset(pdf_base, pages = len:1) # 逆順
odd_pages <- seq(from = 1, to = len, by = 2)       # 奇数ページのみ
pdf_odd <- pdf_subset(pdf_base, pages = odd_pages)
odd_rev <- sort(odd_pages, decreasing = TRUE)      # 奇数ページの逆順
pdf_odd_rev <- pdf_subset(pdf_base, pages = odd_rev)

