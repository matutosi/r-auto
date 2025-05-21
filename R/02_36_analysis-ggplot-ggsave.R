  # 作図のファイルへの保存
  # 02_36_analysis-ggplot-ggsave.R
path <- fs::file_temp(ext = "png") # 保存先のパスの拡張子を指定
ggplot2::ggsave(path, gg_sales)

