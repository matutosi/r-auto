  # 画像内の文字認識
  # 11_32_image-ocr.R
jps <- "jps.png"
url <- paste0("https://matutosi.github.io/r-auto/data/", jps)
path <- fs::path_temp(jps)
curl::curl_download(url, path)
path |>
  image_read() |>
  image_ocr(lang = "jpn") |>
  cat()

