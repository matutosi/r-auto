  # パラメータの変更
  # 14_22_ai-gemini-parameter-fun.R
gemini_para <- function(prompt, temperature){
  # (中略)
  response <- POST(
  # (中略)
    body = list(
  # (中略)
      generationConfig = list(
        temperature = temperature, # 既定値は0.5
        maxOutputTokens = 1024
      )
    )
  )
  # (中略)
}

