  # 作図の繰り返し
  # 02_46_analysis-purrr-split-imap.R
gg_sales_split <- 
  sales_joined |>
  group_split(shop) |>
  purrr::imap(
    \(.x, .y){
      ggplot2::ggplot(.x, ggplot2::aes(period, count, group = item)) +
      ggplot2::geom_line(aes(color = item)) + # 線の色をitemに対応させる
      ggplot2::theme_bw() +                   # 白黒のテーマ
      ggplot2::theme(text = ggplot2::element_text(family = "Yu Mincho", 
                     size = 20)) + # フォント種類とフォントサイズ
      ggplot2::guides(x = ggplot2::guide_axis(angle = 90)) + # x軸の重なり防止
      ggplot2::labs(title = .y)                              # タイトル
    }
  )

