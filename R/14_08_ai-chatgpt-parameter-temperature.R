  # パラメータによる回答の制御
  # 14_08_ai-chatgpt-parameter-temperature.R
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

