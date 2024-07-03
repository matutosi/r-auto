  # PDFの結合
  # 07_12_pdf-combine.R
pdf_spl |>                      # 分割したPDF
  purrr::map_int(pdf_length)    # 各PDFのページ数
pdf_com <- pdf_combine(pdf_spl) # 結合
fs::path_file(pdf_com)          # 結合したファイル名
pdf_length(pdf_com)             # 結合したPDFのページ数

