  # 下書きメールの一斉送信
  # 12_39_mail-ms365r-auto-drafts-send.R
outlook$get_drafts()$list_emails() |>
  purrr::map(function(x){ x$send() })

