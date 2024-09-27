  # 中間言語を使った文章の改善
  # 13_14_translate-pimp2.R
text <- "In former times I lived in Kobe"
pimp2(text = text, source_lang = "EN", help_lang = "JA", auth_key = deepl_key)
text <- "私の大きい兄弟は、仕事を教師です。" # 変な日本語
pimp2(text = text, source_lang = "JA", help_lang = "EN", auth_key = deepl_key)

