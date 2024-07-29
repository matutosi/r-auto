  # ページ番号を重ね合わせる関数
  # 07_20_pdf-add-page-numbers-fun.R
add_page_numbers <- function(path, y_pos = 5, size = 5, 
                             colour = "black", backside = FALSE, ...){
  pdf_spl <- pdftools::pdf_split(path) # 分割
  n <- length(pdf_spl)                 # PDFのページ数
  pdf_pages <- 
    gen_page_numbers(n = n, y_pos = y_pos, # ページ番号のPDF生成
                     size = size, colour = colour, ...)
  if(backside){ # 上下入れ替え
    tmp <- pdf_pages
    pdf_pages <- pdf_spl
    pdf_spl <- tmp
  }
  pdf_paged <- purrr::map2_chr(
    pdf_pages, pdf_spl, qpdf::pdf_overlay_stamp) # ページ番号の重ね合わせ
  pdf_com <- pdftools::pdf_combine(pdf_paged)    # PDFの結合
  fs::file_delete(c(pdf_pages, pdf_paged))       # 不要なPDFの削除
  return(pdf_com)
}

