  # PDFから文字列の抽出
  # 07_15_pdf-text.R
text <- 
  pdf_spl[1:3] |>     # 1-3ページ
  pdf_combine() |>    # 結合
  pdf_text() # 文字列の抽出
text |>
  stringr::str_split("\n") # 改行(\n)で分割

