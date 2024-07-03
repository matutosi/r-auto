  # PDFを画像ファイルに変換
  # 07_17_pdf-convert.R
  # pdf_convert(pdf_base, pages = 1:2) # かなり時間がかかる
pdf_combine(pdf_spl[1:2]) |>
  pdf_convert(filenames = paste0("072_", 1:2, ".png")) # 既定値の72dpi
pngs <- 
  pdf_combine(pdf_spl[1:2]) |>
  pdf_convert(filenames = paste0("300_", 1:2, ".png"), dpi = 300)

