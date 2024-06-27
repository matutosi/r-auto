  # 下書きメールの一斉削除
  # 12_40_mail-ms365r-auto-drafts-delete.R
outlook$get_drafts()$list_emails() |>
  purrr::map(function(x){ x$delete(confirm = FALSE) })

