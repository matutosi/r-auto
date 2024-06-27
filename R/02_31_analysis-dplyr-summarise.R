  # 平均や最大値などの集計
  # 02_31_analysis-dplyr-summarise.R
dplyr::group_by(answer, area) |> 
  dplyr::summarise(m_period = mean(period), m_satisfy = mean(satisfy))

