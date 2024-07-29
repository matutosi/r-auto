  # 作業用PDFのダウンロード
  # 07_02_pdf-download.R
  # install.packages("curl")
url <- "https://matutosi.github.io/r-auto/data/base.pdf"
pdf_base <- fs::path_temp("base.pdf")
curl::curl_download(url, pdf_base) # urlからPDFをダウンロード

