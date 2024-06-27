  # DALL-Eによる画像生成(英語で指示)
  # 14_11_ai-chatgpt-create-image.R
ask_chatgpt(paste0("英語に翻訳してください．\n", prompt))
prompt <- "Please generate a glowing letter \"R\" on a white background."
response <- create_image(prompt, n = n, size = "256x256")
pngs <- fs::path(fs::path_home(), "desktop", paste0((n+1):(n*2), ".png"))
purrr::map2(response$data$url, pngs, curl::curl_download)

