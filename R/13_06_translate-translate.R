  # 翻訳の例
  # 13_06_translate-translate.R
text <- "This is an example of a translation by DeepL." # もとの文
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)
 ## [1] "これはDeepLによる翻訳の例である。"

