  # .byを使った平均や最大値などの集計
  # 02_22_analysis-dplyr-summarise-by.R
dplyr::summarise(answer_mutated, m_years = mean(years), 
                 m_satisfy = mean(satisfy), .by = area)

