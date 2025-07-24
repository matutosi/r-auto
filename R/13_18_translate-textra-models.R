  # モデルによる翻訳の違い
  # 13_18_translate-textra-models.R
sample <- "I am a cat. I have no name. It is fine today."
textra(sample, params = params)                     # 新エンジン(既定値)
textra(sample, params = params, model = "patentNT") # 特許
textra(sample, params = params, model = "seikatsu") # 日常会話

