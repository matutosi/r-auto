  # 個数を数える
  # 02_24_analysis-dplyr-n.R
dplyr::group_by(answer_mutated, area) |> 
  dplyr::summarise(n = n())

