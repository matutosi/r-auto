  # パラメータの変更
  # 14_19_ai-gemini-parameter-fun.R
gemini_para <- function(prompt, temperature){
  # (省略)
  generationConfig = list(
    temperature = temperature, # 既定値は0.5
    maxOutputTokens = 1024
  )
  # (省略)
}

