  # Geminiでの図の説明
  # 14_16_ai-gemini-gemini-images.R
prompt <- "写真全体の説明をしてください。生物がいる場合は、その説明もお願いします。"
url <- "https://matutosi.github.io/r-auto/data/"
urls <- paste0(url, "image_0", 1:3, ".jpg")
jpgs <- fs::path_temp(paste0("image_0", 1:3, ".jpg"))
curl::multi_download(urls, jpgs)
comments <- list()
for(jpg in jpgs){
  comments[[jpg]] <- gemini_image(jpg, prompt)
}
comments

