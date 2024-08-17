  # TexTraの認証情報の取得
  # 13_17_translate-textra-auth.R
textra_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # APIキー
textra_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"        # API secret
name <- "LOGIN_ID"                                         # ログインID
params <- gen_params(key = textra_key,                     # 認証情報
                     secret = textra_secret, name = name)

