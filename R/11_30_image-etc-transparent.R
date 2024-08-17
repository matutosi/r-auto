  # PDFファイルの背景の透明化
  # 11_30_image-etc-transparent.R
path <- fs::path_temp(c("gg_1.pdf", "gg_2.pdf"))      # 個別の散布図のPDF
path_out <- fs::path_temp(c("fill.pdf", "trans.pdf")) # 重ね合わせしたPDF
tibble(path = path, 
       color = c("black", "red"),
       size = c(1, 5),
       fill = c("black", "white")) |>
  purrr::pwalk(gg_point)
  # 透明化・重ね合わせ
qpdf::pdf_overlay_stamp(path[1], path[2], out = path_out[1]) # 透明化前
purrr::walk(path, pdf_transparent)                           # 透明化
qpdf::pdf_overlay_stamp(path[1], path[2], out = path_out[2]) # 透明化後
out <- pdftools::pdf_combine(c(path, path_out))              # 全PDFを結合
  # shell.exec(out)

