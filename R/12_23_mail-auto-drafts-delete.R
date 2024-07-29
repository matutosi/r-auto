  # 下書きメールの一斉削除
  # 12_23_mail-auto-drafts-delete.R
gm_drafts() |>
  gm_id() |>
  purrr::map(gm_delete_draft)

