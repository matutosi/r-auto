  # .byを使った平均や最大値などの集計
  # 02_22_analysis-dplyr-summarise-by.R
dplyr::summarise(answer,m_period = mean(period), m_satisfy = mean(satisfy), 
                 .by = area)

