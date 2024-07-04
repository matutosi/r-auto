  # 個数を数える
  # 02_35_analysis-dplyr-n.R
dplyr::group_by(answer, area) |> 
  dplyr::summarise(n = n())

