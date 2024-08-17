  # メールの作成と下書きの保存
  # 12_27_mail-ms365r-create-email.R
email <- outlook$create_email(subject = "メールの件名", to = "hogehoge@gmail.com"
                              body = "メールの本文", send_now = FALSE)

