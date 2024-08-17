  # Geminiでの図の説明
  # 14_16_ai-gemini-gemini-images.R
prompt <- "写真の全体の説明をしてください．また，生物がいる場合は，その生物の説明もお願いします．"
url <- "https://matutosi.github.io/r-auto/data/"
jpgs <- paste0(url, "image_0", 1:3, ".jpg")
comments <- list()
for(jpg in jpgs){
  comments[[jpg]] <- gemini_image(prompt, jpg)
}
comments

