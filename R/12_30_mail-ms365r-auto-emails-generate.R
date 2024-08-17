  # メールの一斉作成
  # 12_30_mail-ms365r-auto-emails-generate.R
outlook <- get_business_outlook()     # 職場または学校アカウント
emails <- auto_emails(path = "email.xlsx", outlook)

