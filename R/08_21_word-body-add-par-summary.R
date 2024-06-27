  # 作成中の文書の概要
  # 08_21_word-body-add-par-summary.R
docx_summary(doc_2) |>
  tibble::as_tibble() # 見やすくするためにtibbleに変換

