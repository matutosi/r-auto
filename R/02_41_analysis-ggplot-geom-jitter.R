  # ```{r analysis-ggplot-geom-jitter, eval = FALSE, tidy = FALSE, subject = 'geom_jitter()', caption = 'ジッター・プロット'}
  # 02_41_analysis-ggplot-geom-jitter.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_jitter()

