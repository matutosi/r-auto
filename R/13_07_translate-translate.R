  # 翻訳の例
  # 13_07_translate-translate.R
text <- "This is an example of a translation by DeepL." # もとの文
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)

