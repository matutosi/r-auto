  # 画像のダウンロード
  # 11_02_image-download.R
rs <- paste0("r_", stringr::str_pad(1:24, 2, "left", "0"), ".png")
pts <- paste0("image_", c("01", "02", "03"), ".jpg")
files <- c(rs, pts)
urls <- paste0("https://matutosi.github.io/r-auto/data/", files)
files <- fs::path_temp(files)
curl::multi_download(urls, files)

