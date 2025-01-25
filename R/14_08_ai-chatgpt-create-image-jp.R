  # DALL-Eによる画像生成
  # 14_08_ai-chatgpt-create-image-jp.R
install.packages("openai")
library(openai)
response <- openai::create_image("光り輝く「R」という文字を生成してください。")
png <- fs::path(fs::path_home("Desktop/r.png")) # ダウンロード先
curl::curl_download(response$data$url, png)     # ダウンロード

