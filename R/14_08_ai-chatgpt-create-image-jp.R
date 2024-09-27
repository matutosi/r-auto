  # DALL-Eによる画像生成(疑似コード)
  # 14_08_ai-chatgpt-create-image-jp.R
install.packages("openai")
library(openai)
response <- openai::create_image("光り輝く「R」という文字を生成してください。")
pngs <- fs::path(fs::path_home("Desktop/r.png"))          # ダウンロード先
purrr::map2(response$data$url, pngs, curl::curl_download) # ダウンロード

