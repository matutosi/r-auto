  # 翻訳の例
  # 13_07_translate-translate.R
text <- "This is an example of a translation by DeepL."
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)
 ## [1] "これはDeepLによる翻訳の例である。"
text <- "I am a cat. I have no name. It is fine today." # 夏目漱石の「吾輩は猫である」
translate2(text = text, target_lang = "JA", 
  source_lang = "EN", auth_key = deepl_key)
 ## 私は猫だ。名前はない。今日も元気だ。

