  # パワーポイントの読み込み
  # 10_02_powerpoint-read.R
url <- "https://matutosi.github.io/r-auto/data/slide.pptx"
path <- fs::path_temp("slide.pptx")
curl::curl_download(url, path) # urlからPDFをダウンロード
pp <- read_pptx(path)

