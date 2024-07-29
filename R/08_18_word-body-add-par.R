  # 文書にパラグラフを追加
  # 08_18_word-body-add-par.R
doc_2 <- 
  doc_2 |>
  body_add_par(value = "大項目(heading 1)", style = "heading 1") |>
  body_add_par(value = "中項目(heading 2)", style = "heading 2") |>
  body_add_par(value = "小項目(heading 3)", style = "heading 3") |>
  body_add_par(value = "これは本文です(Normal)．", style = "Normal") |>
  body_add_par(value = "「オラウータン」は間違いです．", style = "Normal") |>
  body_add_par(value = "「オランウータン」が正解です．", style = "Normal") |>
  body_add_par(value = "「オラウンタン」も違います．", style = "Normal") |>
  body_add_break() |>
  body_add_par(value = "これは2ページ目の本文です", style = "Normal")
doc_2

