  # ジッター・プロット
  # 02_32_analysis-ggplot-geom-jitter.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_jitter()

