  # 2値化した画像の文字認識
  # 11_35_image-binarization-ocr.R
img_bin |>
  image_ocr(lang = "jpn") |>
  cat()

