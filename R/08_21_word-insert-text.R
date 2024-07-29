  # 文字列をまとめて入力
  # 08_21_word-insert-text.R
text <- 
  c("これは2ページ目の本文です．",
    "甲南女子学園は2020年11月27日に100周年を迎えました．",
    "2025年3月18日(月)：卒業式",
    "2025年4月3日(金)：入学式",
    "曜日は未確認です．",
    paste0(rep("これは長い文章の例です．", 5), collapse = "")
    )
doc_2 <- insert_text(doc_2, text)
docx_summary(doc_2) |>
  tibble::as_tibble() |> # tibbleに変換
  dplyr::select(-c(content_type, level, num_id)) |> # 列を除去
  tail(8) # 最後の8行のみ

