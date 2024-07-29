  # 下書きメールの一斉送信
  # 12_36_mail-ms365r-auto-drafts-send.R
outlook$get_drafts()$list_emails() |>
  purrr::map( \(x){ x$send() })

