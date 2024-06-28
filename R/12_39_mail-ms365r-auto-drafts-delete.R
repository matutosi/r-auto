  # 下書きメールの一斉削除
  # 12_39_mail-ms365r-auto-drafts-delete.R
outlook$get_drafts()$list_emails() |>
  purrr::map( \(x){ x$delete(confirm = FALSE) })

