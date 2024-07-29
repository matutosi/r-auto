  # テーマの変更(擬似コード)
  # 02_51_analysis-ggplot-theme.R
df |>
  ggplot2::ggplot(, ggplot2::aes(x, y)) +
  ggplot2::geom_point() +  # 散布図
  ggplot2::theme_bw()      # 白黒のシンプルなテーマに変更

