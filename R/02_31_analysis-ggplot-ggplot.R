  # 基本的な描画(箱ひげ図)
  # 02_31_analysis-ggplot-ggplot.R
sales_joined |>
  ggplot2::ggplot(ggplot2::aes(x = item, y = count)) + 
  ggplot2::geom_boxplot() + 
  ggplot2::theme(text = ggplot2::element_text(size = 20)) + # フォントを大きく
  ggplot2::guides(x = ggplot2::guide_axis(n.dodge = 2))     # x軸の重なり防止

