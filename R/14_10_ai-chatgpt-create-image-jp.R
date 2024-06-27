  # DALL-Eによる画像生成(日本語で指示)
  # 14_10_ai-chatgpt-create-image-jp.R
prompt <- "背景は白色で光り輝く「R」という文字を生成してください．"
n <- 5
response <- create_image(prompt, n = n, size = "256x256")
response$data$url
pngs <- fs::path(fs::path_home(), "desktop", paste0(1:n, ".png"))
purrr::map2(response$data$url, pngs, curl::curl_download)

