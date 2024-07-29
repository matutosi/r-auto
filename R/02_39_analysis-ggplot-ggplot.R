  # 基本的な描画(箱ひげ図)
  # 02_39_analysis-ggplot-ggplot.R
sales |>
  ggplot2::ggplot(ggplot2::aes(x = item, y = count)) + 
  ggplot2::geom_boxplot()

