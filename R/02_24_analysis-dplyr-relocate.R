  # 列の順序変更
  # 02_24_analysis-dplyr-relocate.R
dplyr::relocate(answer, apps) |> head(3)
dplyr::relocate(answer, comment, .before = apps) |> head(3)

