  # ページ番号だけのページを作成する関数
  # 07_23_pdf-plot-page-number.R
plot_page_number <- function(label, x_pos = width / 2, y_pos = 5,
                             size = 5, colour = "black", 
                             width = 210, height = 297, ...){
  tibble::tibble(x_pos = x_pos, y_pos = y_pos, label = label) |>
  ggplot2::ggplot(ggplot2::aes(x_pos, y_pos, label = label)) +
    ggplot2::geom_text(size = size, colour = colour, ...) + # ページ数の描画
    # x軸とy軸の設定
    ggplot2::scale_x_continuous(limits = c(0, width) , expand = c(0, 0)) + 
    ggplot2::scale_y_continuous(limits = c(0, height), expand = c(0, 0)) + 
    ggplot2::theme_void()
}

