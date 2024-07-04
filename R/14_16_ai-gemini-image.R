  # 作業用のグラフの生成
  # 14_16_ai-gemini-image.R
library(ggplot2)
gg <- fs::path_temp("gg.png")
ggplot(mpg, aes(cty, hwy)) + geom_point() + theme_bw()
ggsave(gg, width = 5, height = 5)

