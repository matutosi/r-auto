  # Gmailの内容表示
  # 12_08_mail-gm-messages.R
messages <- gm_messages(search = "検索文字列", num_results = 3)
messages
gm_id(messages)[[1]]  |>
  gm_message()
threads <- gm_messages(search = "検索文字列", num_results = 3)
gm_id(threads)[[1]]  |>
  gm_message()

