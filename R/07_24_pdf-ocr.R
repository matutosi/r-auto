  # PDF内の画像の文字認識
  # 07_24_pdf-ocr.R
ocr_data <- pdf_split(pdf_base)[1] |> pdf_ocr_data(language = "jpn") |> `[[`(_, 1) 
head(ocr_data, 3)
pdf_split(pdf_base)[1] |> pdf_ocr_text(language = "jpn") |> 
  stringr::str_split("\n") |> `[[`(_, 1) |> head(3)

