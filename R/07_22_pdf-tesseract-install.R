  # tesseractのインストールと言語モデルのダウンロード
  # 07_22_pdf-tesseract-install.R
install.packages("tesseract")
tesseract::tesseract_download(lang = "jpn")

