  # deeplrによる翻訳(map版)
  # 13_11_translate-translated-safely.R
text <- en$segment_text
translate2_possibly <- purrr::possibly(translate2, otherwise = "!翻訳エラー")
translated <- 
  text |>
  purrr::map_chr(translate2_possibly, target_lang = "JA", auth_key = deepl_key)
translated
 ## (2番目がエラーのときの結果の例)
 ## [1] "白樺のカヌーは滑らかな板の上を滑った。紺色の背景にシートを..."
 ## [2] "!翻訳エラー"
 ## [3] "水槽には2匹の青い魚が泳いでいた。彼女の財布は無駄なゴミで..."

