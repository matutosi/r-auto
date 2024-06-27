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
 ## [1] "白樺のカヌーは滑らかな板の上を滑った。紺色の背景にシートを..."
 ## [2] "大河の源は清流。ボールをまっすぐ蹴り、フォロースルー。女性..."
 ## [3] "水槽には2匹の青い魚が泳いでいた。彼女の財布は無駄なゴミで..."

