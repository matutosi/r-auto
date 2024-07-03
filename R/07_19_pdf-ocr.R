  # PDF内の画像の文字認識
  # 07_19_pdf-ocr.R
ocr_data <- 
  pdf_ocr_data(pdf_spl[1], language = "jpn") |>
  magrittr::extract2(1) # [[[1]]と同じ
head(ocr_data)
pdf_ocr_text(pdf_spl[1], language = "jpn") |>
  stringr::str_split("\n") |>
  magrittr::extract2(1) |> # [[[1]]と同じ
  head()

