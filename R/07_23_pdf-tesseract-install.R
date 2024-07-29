  # tesseractのインストールと言語モデルのダウンロード
  # 07_23_pdf-tesseract-install.R
install.packages("tesseract")
tesseract::tesseract_download(lang = "jpn")

