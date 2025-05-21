  # facetによる散布図の分割
  # 02_35_analysis-ggplot-facet-wrap.R
sales_joined |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_boxplot() + 
  ggplot2::facet_wrap(vars(shop)) + 
  ggplot2::theme(text = ggplot2::element_text(size = 16)) + # フォントを大きく
  ggplot2::guides(x = ggplot2::guide_axis(angle = 90)) # x軸の重なり防止

