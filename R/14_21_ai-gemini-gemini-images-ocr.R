  # Geminiでの文字認識
  # 14_21_ai-gemini-gemini-images-ocr.R
url <- "https://matutosi.github.io/r-auto/data/jps.png"
prompt <- "画像内の文字を教えて下さい．"
str <- 
  gemini_image(prompt, url) |>
  stringr::str_split_1("\n")
str

