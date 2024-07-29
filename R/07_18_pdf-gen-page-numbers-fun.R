  # 複数ページ分のページ番号のPDFを生成する関数
  # 07_18_pdf-gen-page-numbers-fun.R
gen_page_numbers <- function(n, x_pos = width / 2, y_pos = 5, 
                             size = 5, colour = "black", 
                             width = 210, height = 297, ...){
  pages <- seq(n)
  filename <- fs::path_temp(paste0(pages, ".pdf"))
  page_numbers <- 
    purrr::map(pages, plot_page_number,  # ページごとで繰り返し
               x_pos = x_pos, y_pos = y_pos, 
               size = size, colour = colour, 
               width = width, height = height, ...)
  purrr::walk2( # ページごとにファイルを書き込み
    filename, page_numbers, 
    ggplot2::ggsave, 
      width = width, height = height, units ="mm", bg = "transparent")
  return(unlist(filename))
}

