  # 個数を数えるショートカット
  # 02_30_analysis-dplyr-tally.R
dplyr::group_by(answer_mutated, area) |> dplyr::tally() # 出力は省略
dplyr::count(answer_mutated, area)                      # 出力は省略

