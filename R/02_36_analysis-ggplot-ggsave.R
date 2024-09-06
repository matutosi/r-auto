  # 作図のファイルへの保存
  # 02_36_analysis-ggplot-ggsave.R
path <- fs::file_temp(ext = "png")
ggplot2::ggsave(path, gg_sales)

