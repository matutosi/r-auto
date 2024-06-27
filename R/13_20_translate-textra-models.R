  # モデルによる翻訳の違い
  # 13_20_translate-textra-models.R
sample <- "I am a cat. I have no name. It is fine today."
textra(sample, params = params, from = "en", to = "ja")
 ## [1] "私は猫です。 名前はありません。 今日はいい天気です。"
textra(sample, params = params, model = "patentNT", from = "en", to = "ja")
 ## [1] "私は猫であり、名前はない。今日は良い。"
textra(sample, params = params, model = "seikatsu", from = "en", to = "ja")
 ## [1] "私は猫を飼っています。名前は書いてありません。今日はお天気もいいです。"

