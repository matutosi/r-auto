  # deeplrによる翻訳(map版)
  # 13_11_translate-translated-safely.R
text <- en$segment_text
translate2_possibly <- purrr::possibly(translate2, otherwise = "!翻訳エラー")
translated <- 
  text |>
  purrr::map_chr(translate2_possibly, target_lang = "JA", auth_key = deepl_key)
translated

