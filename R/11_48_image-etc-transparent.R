  # PDFファイルの背景の透明化
  # 11_48_image-etc-transparent.R
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
path <- fs::path_temp(c("gg_1.pdf", "gg_2.pdf"))      # 個別の散布図のPDF
path_out <- fs::path_temp(c("fill.pdf", "trans.pdf")) # 重ね合わせしたPDF
tibble(path = path, 
       color = c("black", "red"),
       size = c(1, 5),
       fill = c("black", "white")) |>
  purrr::pwalk(gg_point)
  # 透明化・重ね合わせ
qpdf::pdf_overlay_stamp(path[1], path[2], out = path_out[1]) # 透明化前
purrr::walk(path, pdf_transparent)                           # 透明化
qpdf::pdf_overlay_stamp(path[1], path[2], out = path_out[2]) # 透明化後
out <- pdftools::pdf_combine(c(path, path_out))              # 全PDFを結合
  # shell.exec(out)

