  # deeplrによる翻訳(for版)
  # 13_10_translate-translated.R
text <- en$segment_text
translated <- list()
len <- length(text)
for(i in 1:len){
  translated[i] <- 
    translate2(text[i], target_lang = "JA", auth_key = deepl_key)
}
translated <- unlist(translated)
translated

