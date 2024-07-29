  # PDF内の画像の文字認識
  # 07_24_pdf-ocr.R
ocr_data <- pdf_ocr_data(pdf_spl[1], language = "jpn") |>  `[[`(_, 1)
  head(ocr_data, 3)
pdf_ocr_text(pdf_spl[1], language = "jpn") |>
  stringr::str_split("\n") |>  `[[`(_, 1) |> head(3)

