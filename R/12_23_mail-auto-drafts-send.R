  # 下書きメールの一斉送信
  # 12_23_mail-auto-drafts-send.R
gmails$draft |>
  purrr::walk(gm_send_draft)
  # 下書きを個別に送信するとき
  # gmails$draft[[1]] |>
  #   gm_send_draft()

