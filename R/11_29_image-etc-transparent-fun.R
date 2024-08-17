  # PDFファイルの背景を透明化する関数
  # 11_29_image-etc-transparent-fun.R
gg_point <- function(path, size, color, fill){ # 散布図の描画・保存
  tibble(x = runif(1000), y = runif(1000)) |>
    ggplot(aes(x, y)) + 
    geom_point(shape = 21, size = size, color = color, fill = fill) + 
    theme_bw()
  ggsave(path, width = 5, height = 5)
}
pdf_transparent <- function(path){ # PDF背景の透明化
  path |>
    image_read_pdf() |>
    image_transparent("white") |> # 白を透明化
    image_write(path, format = "pdf")
}

