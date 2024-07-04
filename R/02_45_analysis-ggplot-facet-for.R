  # forとsubset()を使った散布図の分割
  # 02_45_analysis-ggplot-facet-for.R
par(mfcol = c(3, 3))
par(mar = rep(0.1, 4))
par(oma = rep(0.1, 4))
for(s in unique(sales$shop)){
  sales_sub <- subset(sales, shop == s)
  plot(factor(sales_sub$item), sales_sub$count)
}

