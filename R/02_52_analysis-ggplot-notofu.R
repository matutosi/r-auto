  # PDFファイルの文字化け対策
  # 02_52_analysis-ggplot-notofu.R
  # library(extrafont) # 再起動時には必要
library(Cairo)
gg_sales_cairo <- 
  gg_sales + 
  ggplot2::theme(text = ggplot2::element_text(family = "Yu Mincho"))
path <- fs::file_temp(ext = "pdf")
ggplot2::ggsave(path, gg_sales_cairo, 
  device = cairo_pdf, width = 7, height = 7)
  # shell.exec(path)

