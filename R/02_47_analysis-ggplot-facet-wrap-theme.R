  # テーマの変更とファセットの追加
  # 02_47_analysis-ggplot-facet-wrap-theme.R
gg_sales + 
  ggplot2::theme_bw() + 
  ggplot2::facet_wrap(vars(shop))

