  # 下書きメールの一斉削除
  # 12_24_mail-auto-drafts-delete.R
gm_drafts() |>
  gm_id() |>
  purrr::map(gm_delete_draft)

