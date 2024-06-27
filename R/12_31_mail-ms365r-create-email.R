  # メールの作成と下書きの保存
  # 12_31_mail-ms365r-create-email.R
body <- "メールの本文.............."
body
 ## [1] "メールの本文.............."
em <- 
  outlook$create_email(
  body = body,
  content_type = "text", # "html"も可能
  subject = "メールの件名",
  to = "hogehoge@gmail.com", 
  cc = NULL, 
  bcc = NULL, 
  reply_to = NULL, 
  send_now = FALSE # FALSE：下書きに保存，TRUE：送信する
)
em # 作成したメールの内容
 ## <Outlook email>
 ##   directory id: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 ##   from:
 ##   sent:
 ##   to: "hogehoge@gmail.com"
 ##   subject: メールの件名
 ## ---
 ## メールの本文..............

