  # ```{r analysis-ggplot-geom-boxplot-geom-jitter, eval = FALSE, subject = 'geom_boxplot(),geom_jitter()', caption = '箱ひげ図とジッター・プロットの重ね合わせ', tidy = FALSE}
  # 02_42_analysis-ggplot-geom-boxplot-geom-jitter.R
gg_sales <- 
  sales |>
  ggplot2::ggplot(ggplot2::aes(item, count)) + 
  ggplot2::geom_boxplot(outlier.color = NA) + # 外れ値の重複を防止
  ggplot2::geom_jitter(width = 0.3, height = 0, size = 0.3) +
  ggplot2::guides(x = ggplot2::guide_axis(n.dodge = 2)) # x軸の重なり防止
gg_sales

