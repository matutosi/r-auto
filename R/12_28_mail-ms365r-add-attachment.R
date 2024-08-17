  # ファイルの添付・作成・削除
  # 12_28_mail-ms365r-add-attachment.R
email$add_attachment("添付ファイル名.xlsx") # ファイルの添付
email$list_attachments() # 添付ファイルの確認
email$send() # メールの送信
outlook$get_drafts()$list_emails() |>  # 一斉削除
  purrr::map(\(x) x$delete(confirm = FALSE) )

