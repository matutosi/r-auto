  # 作業用ファイルのダウンロード
  # 08_02_word-download.R
  # install.packages("curl")
url <- "https://matutosi.github.io/r-auto/data/doc_1.docx"
path_doc_1 <- 
  fs::path_file(url) |>
  fs::path_temp()
curl::curl_download(url, path_doc_1) # urlからPDFをダウンロード
  # shell.exec(path_doc_1)

