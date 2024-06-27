  # ページの重複エラー
  # 07_08_pdf-subset-dup.R
pdf_dup <- pdf_subset(pdf_base, pages = rep(1:3, 2)) # 重複はエラー

