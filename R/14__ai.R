  # chatgptのインストールと呼び出し
  # 14_01_ai-chatgpt-install.R
install.packages("chatgpt")
library(chatgpt)

  # APIキーの設定
  # 14_02_ai-chatgpt-api-key.R
Sys.setenv(OPENAI_API_KEY = "xx-xxxxxxxxxxxxxxxxxxxxxxxx")

  # ChatGPTへの質問
  # 14_03_ai-chatgpt-ask-chatgpt.R
  # (ChatGPTからの回答は読みやすく調整，以下同様)
ask_chatgpt("Rの特徴を教えてください．")

  # セッションのリセット
  # 14_04_ai-chatgpt-ask-reset-chat-session.R
ask_chatgpt("あなたは優秀な英語の教師です．")
ask_chatgpt("あなたは何の教師ですか．")
reset_chat_session() # セッションをリセット
ask_chatgpt("あなたは何の教師ですか．")

  # コードの説明
  # 14_05_ai-chatgpt-explain-code.R
code <- '
df <- readr::read_csv("sample.csv") |>
  filter(df, yr == 2024) |>
  arrange(name)
'
explain_code(code)

  # 日本語でのコードの説明
  # 14_06_ai-chatgpt-explain-code-jp.R
Sys.setenv(OPENAI_RETURN_LANGUAGE = "Japanese")
code <- '
df <- readr::read_csv("sample.csv") |>
  filter(df, yr == 2024) |>
  arrange(name)
'
explain_code(code)

  # パラメータによる回答の制御
  # 14_07_ai-chatgpt-parameter-temperature.R
  # 以前の内容を引き継がないように，毎回セッションをリセット
library(chatgpt)
prompt <- "「昔々あるところに」に続けて自由な物語を考えてください．"
Sys.setenv(OPENAI_TEMPERATURE = 0)
reset_chat_session()
ask_chatgpt(prompt)
reset_chat_session()
ask_chatgpt(prompt)
Sys.setenv(OPENAI_TEMPERATURE = 1.5)
reset_chat_session()
ask_chatgpt(prompt)
reset_chat_session()
ask_chatgpt(prompt)

  # openaiのインストールと呼び出し
  # 14_08_ai-chatgpt-openai.R
install.packages("openai")
library(openai)

  # DALL-Eによる画像生成(日本語での指示)
  # 14_09_ai-chatgpt-create-image-jp.R
prompt <- "背景は白色で光り輝く「R」という文字を生成してください．"
n <- 5
response <- create_image(prompt, n = n, size = "256x256")
response$data$url
pngs <- fs::path(fs::path_home(), "desktop", paste0(1:n, ".png"))
purrr::map2(response$data$url, pngs, curl::curl_download)

  # DALL-Eによる画像生成(英語での指示)
  # 14_10_ai-chatgpt-create-image.R
ask_chatgpt(paste0("英語に翻訳してください．\n", prompt))
prompt <- "Please generate a glowing letter \"R\" on a white background."
response <- create_image(prompt, n = n, size = "256x256")
pngs <- fs::path(fs::path_home(), "desktop", paste0((n+1):(n*2), ".png"))
purrr::map2(response$data$url, pngs, curl::curl_download)

  # gemini.Rのインストールと呼び出し
  # 14_11_ai-gemini-r-install.R
remotes::install_github("jhk0530/gemini.R")
library(gemini.R)

  # APIキーの設定
  # 14_12_ai-gemini-api-key.R
gemini_api_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
setAPI(gemini_api_key)

  # 作業用文章の準備
  # 14_13_ai-gemini-rvest.R
  # 寺田寅彦 学問の自由
url <- "https://www.aozora.gr.jp/cards/000042/files/43535_24583.html"
text <- 
  url |>
  rvest::read_html() |>
  rvest::html_elements(".main_text") |>
  rvest::html_text() |>
  stringr::str_remove_all("\\s+") # 空白文字を削除
stringr::str_sub(text, 1, 34)     # 1-34文字目の表示

  # Geminiへの質問
  # 14_14_ai-gemini-gemini.R
  # (Geminiからの回答を読みやすく調整済み，以下同様)
prompt <- paste0("次の文章を200文字程度に要約してください．\n",text)
gemini(prompt)

  # Geminiへの連続的な質問
  # 14_15_ai-gemini-gemini-chat.R
chat <- gemini_chat(prompt) 
chat$outputs
prompt <- "要約をさらに短くして，1文にまとめてください．"
chat <- gemini_chat(prompt, chat$history)
chat$outputs
prompt <- "文章には，自由な研究には何が重要だと書かれていますか．"
chat <- gemini_chat(prompt, chat$history)
chat$outputs

  # 作業用のグラフの生成
  # 14_16_ai-gemini-image.R
library(ggplot2)
gg <- fs::path_temp("gg.png")
ggplot(mpg, aes(cty, hwy)) + geom_point() + theme_bw()
ggsave(gg, width = 5, height = 5)

  # Geminiでのグラフの説明
  # 14_17_ai-gemini-gemini-image.R
prompt <- "グラフの説明をしてください．"
gemini_image(prompt, gg)

  # Geminiでの図の説明
  # 14_18_ai-gemini-gemini-images.R
prompt <- "写真の全体の説明をしてください．また，生物がいる場合は，その生物の説明もお願いします．"
url <- "https://matutosi.github.io/r-auto/data/"
jpgs <- paste0(url, "image_0", 1:3, ".jpg")
comments <- list()
for(jpg in jpgs){
  comments[[jpg]] <- gemini_image(prompt, jpg)
}
comments

  # Geminiでの文字認識
  # 14_19_ai-gemini-gemini-images-ocr.R
url <- "https://matutosi.github.io/r-auto/data/jps.png"
prompt <- "画像内の文字を教えて下さい．"
str <- 
  gemini_image(prompt, url) |>
  stringr::str_split_1("\n")
str

  # パラメータの変更
  # 14_20_ai-gemini-parameter-fun.R
gemini_para <- function(prompt, temperature){
  # (省略)
  generationConfig = list(
    temperature = temperature, # 既定値は0.5
    maxOutputTokens = 1024
  )
  # (省略)
}

  # 各種パッケージの呼び出し
  # 14_21_ai-gemini-library-others.R
library(httr)
library(jsonlite)
library(base64enc)
prompt <- クイズを3つ出してください．
gemini_para(prompt, temperature = 0)
gemini_para(prompt, temperature = 0)
gemini_para(prompt, temperature = 0)
gemini_para(prompt, temperature = 1)
gemini_para(prompt, temperature = 1)
gemini_para(prompt, temperature = 1)

