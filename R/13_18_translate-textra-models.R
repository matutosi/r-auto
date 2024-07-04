  # モデルによる翻訳の違い
  # 13_18_translate-textra-models.R
sample <- "I am a cat. I have no name. It is fine today."
textra(sample, params = params)                     # 新エンジン(既定値)
 ## [1] "私は猫です。 名前はありません。 今日はいい天気です。"
textra(sample, params = params, model = "patentNT") # 特許
 ## [1] "私は猫であり、名前はない。今日は良い。"
textra(sample, params = params, model = "seikatsu") # 日常会話
 ## [1] "私は猫を飼っています。名前は書いてありません。今日はお天気もいいです。"

