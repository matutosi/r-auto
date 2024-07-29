  # 文書への図表の追加
  # 08_23_word-boy-add-img.R
img <- "https://matutosi.github.io/r-auto/data/r_gg.png" # 画像
gg_point <-                                              # ggplot
  tibble::tibble(x = rnorm(100), y = runif(100)) |>
  ggplot2::ggplot(ggplot2::aes(x, y)) + 
  ggplot2::geom_point()
mpg_tbl <- head(mpg[,1:6])                               # 表
doc_2 <- 
  doc_2 |>
  body_add_break() |>                                    # 改ページ
  body_add_img(img, width = 3, height = 3) |>            # 画像の追加
  body_add_gg(gg_point, width = 3, height = 3) |>        # ggplotの追加
  body_add_break() |>
  body_add_table(mpg_tbl)                                # 表の追加

