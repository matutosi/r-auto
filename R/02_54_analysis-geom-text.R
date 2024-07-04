  # プロット内に日本語を入れる
  # 02_54_analysis-geom-text.R
tibble::tibble(x = 1:5, y = 1:5, label = c("あ", "い", "う", "え", "お")) |>
  ggplot2::ggplot(aes(x, y, label = label)) +
  ggplot2::geom_text(family = "Yu Mincho", size = 10)
path <- fs::file_temp(ext = "pdf")
ggplot2::ggsave(path, device = cairo_pdf)
  # shell.exec(path)

