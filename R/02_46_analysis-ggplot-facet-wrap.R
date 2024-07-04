  # facetによる分割して作図
  # 02_46_analysis-ggplot-facet-wrap.R
sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
    ggplot2::geom_boxplot() + 
    ggplot2::facet_wrap(vars(shop))

