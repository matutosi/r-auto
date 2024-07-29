  # パラメータによる回答の制御
  # 14_20_ai-gemini-parameter.R
library(httr)
library(jsonlite)
library(base64enc)
prompt <- クイズを3つ出してください．
gemini_para(prompt, temperature = 0)
gemini_para(prompt, temperature = 0)
gemini_para(prompt, temperature = 1)
私は何ですか？
gemini_para(prompt, temperature = 1)

