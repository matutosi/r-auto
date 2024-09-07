  # 個数を数えるショートカット
  # 02_30_analysis-dplyr-tally.R
dplyr::group_by(answer, area) |> dplyr::tally() # 出力は省略
dplyr::count(answer, area) # 出力は省略

