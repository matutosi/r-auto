  # ```{r analysis-dplyr-summarise-by, tidy = FALSE, subject = 'summarise()', caption = '.byを使った平均や最大値などの集計'}
  # 02_32_analysis-dplyr-summarise-by.R
dplyr::summarise(answer,m_period = mean(period), m_satisfy = mean(satisfy), 
                 .by = area)

