  # 下書きメールの送信
  # 12_22_mail-auto-drafts-send.R
purrr::walk(gmails$draft, gm_send_draft) # 一斉送信
  # gm_send_draft(gmails$draft[[1]])     # 個別に送信

