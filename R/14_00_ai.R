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

  # DALL-Eによる画像生成(疑似コード)
  # 14_08_ai-chatgpt-create-image-jp.R
install.packages("openai")
library(openai)
response <- openai::create_image("光り輝く「R」という文字を生成してください．")
pngs <- fs::path(fs::path_home("Desktop/r.png"))          # ダウンロード先
purrr::map2(response$data$url, pngs, curl::curl_download) # ダウンロード

  # gemini.Rのインストールと呼び出し
  # 14_09_ai-gemini-r-install.R
remotes::install_github("jhk0530/gemini.R")
library(gemini.R)

  # APIキーの設定
  # 14_10_ai-gemini-api-key.R
gemini_api_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
setAPI(gemini_api_key)

  # 作業用文章の準備
  # 14_11_ai-gemini-rvest.R
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
  # 14_12_ai-gemini-gemini.R
  # (Geminiからの回答を読みやすく調整済み，以下同様)
prompt <- paste0("次の文章を200文字程度に要約してください．\n",text)
gemini(prompt)

  # Geminiへの連続的な質問
  # 14_13_ai-gemini-gemini-chat.R
chat <- gemini_chat(prompt)
chat$outputs
prompt <- "要約をさらに短くして，1文にまとめてください．"
chat <- gemini_chat(prompt, chat$history)
chat$outputs
prompt <- "文章には，自由な研究には何が重要だと書かれていますか．"
chat <- gemini_chat(prompt, chat$history)
chat$outputs

  # 作業用のグラフの生成
  # 14_14_ai-gemini-image.R
library(ggplot2)
gg <- fs::path_temp("gg.png")
ggplot(mpg, aes(cty, hwy)) + geom_point() + theme_bw()
ggsave(gg, width = 5, height = 5)

  # Geminiでのグラフの説明
  # 14_15_ai-gemini-gemini-image.R
prompt <- "グラフの説明をしてください．"
gemini_image(image = gg, prompt = prompt)

  # Geminiでの図の説明
  # 14_16_ai-gemini-gemini-images.R
prompt <- "写真の全体の説明をしてください．また，生物がいる場合は，その生物の説明もお願いします．"
url <- "https://matutosi.github.io/r-auto/data/"
jpgs <- paste0(url, "image_0", 1:3, ".jpg")
comments <- list()
for(jpg in jpgs){
  comments[[jpg]] <- gemini_image(jpg, prompt)
}
comments

  # パラメータによる回答の制御
  # 14_17_ai-gemini-parameter.R
prompt <- "クイズを3つ出してください．"
gemini(prompt, temperature = 0)
gemini(prompt, temperature = 0)
gemini(prompt, temperature = 1)
gemini(prompt, temperature = 1)

