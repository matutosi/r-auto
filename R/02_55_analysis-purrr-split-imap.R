  # 作図の繰り返し
  # 02_55_analysis-purrr-split-imap.R
gg_sales_split <- 
  sales |>
  split_by("shop") |>
  purrr::imap(
    \(.x, .y){
      ggplot2::ggplot(.x, ggplot2::aes(period, count, group = item)) +
      ggplot2::geom_line(aes(color = item)) +
      ggplot2::theme_bw() + 
      ggplot2::theme(text = ggplot2::element_text(family = "Yu Mincho")) + 
      ggplot2::labs(title = .y)
    }
  )

