  # 再起動時のトークンの呼び出し
  # 12_08_mail-gm-token-read.R
library(gmailr)
token <- gm_token_read("gmailr-token.rds")
gm_auth(token = token)
gm_profile()
  # Logged in as:
  #   * email: YOURNAME@gmail.com
  #   * num_messages: 123456
  #   * num_threads: 78901

