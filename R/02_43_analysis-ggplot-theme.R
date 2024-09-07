  # テーマの変更
  # 02_43_analysis-ggplot-theme.R
gg <- 
  tibble::tibble(x = rnorm(100), y = runif(100)) |>
  ggplot2::ggplot(ggplot2::aes(x, y)) +
  ggplot2::geom_point() +  # 散布図
  ggplot2::theme_bw()      # 白黒のシンプルなテーマに変更

