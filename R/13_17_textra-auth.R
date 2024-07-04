  # TexTraの認証情報の取得
  # 13_17_textra-auth.R
  # 環境変数に保存したとき
  # textra_key <- Sys.getenv("TEXTRA_KEY")
  # textra_secret <- Sys.getenv("TEXTRA_SECRET")
textra_key <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  # APIキー
textra_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"        # API secret
name <- "LOGIN_ID"                                         # ログインID
params <- gen_params(key = textra_key,                     # 認証情報
                     secret = textra_secret, name = name)

