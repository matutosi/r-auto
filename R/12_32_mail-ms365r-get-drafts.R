  # 下書きフォルダのメール一覧取得
  # 12_32_mail-ms365r-get-drafts.R
drafts <- outlook$get_drafts()$list_emails()
drafts
 ## [[1]]
 ## <Outlook email>
 ##   directory id: Axxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 ##   from:
 ##   sent:
 ##   to: hogehoge@gmail.com
 ##   subject: メールの件名
 ## ---
 ## メールの本文..............
 ## 
 ## [[2]]
 ## <Outlook email>
 ## # (省略)

