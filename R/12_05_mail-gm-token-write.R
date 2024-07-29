  # トークンの保存
  # 12_05_mail-gm-token-write.R
gm_token_write(path = "gmailr-token.rds")
fs::dir_ls(regexp = "rds") # 保存できたか確認
  # gmailr-token.rds

