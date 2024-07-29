  # メールの一斉送信
  # 12_35_mail-ms365r-auto-emails-generate.R
  # outlook <- get_personal_outlook() # 個人用アカウント
outlook <- get_business_outlook()     # 職場または学校アカウント
emails <- auto_emails(path = "email.xlsx", outlook)
emails

