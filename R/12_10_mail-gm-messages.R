  # Gmailの内容表示
  # 12_10_mail-gm-messages.R
messages <- gm_messages(search = "検索文字列", num_results = 3)
messages
gm_id(messages)[[1]]  |>
  gm_message()
  # Id: xxxxxxxxxxxxxx9d
  # To: YOURNAME@gmail.com
  # From: hogehoge@gmail.com
  # Date: Wed, 17 Jan 2024 14:12:06 +0900
  # Subject: メールの件名
  # メールの本文．メールの本文．メールの本文．メールの本文．
  # メールの本文．メールの本文．メールの本文．メールの本文．
  # Attachments: '_main.docx'
gm_id(threads)[[1]]  |>
  gm_message()
  # Id: xxxxxxxxxxxxxx9d
  # To: hogehoge@gmail.com
  # (以下省略)

