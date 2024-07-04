  # 複数の図の保存
  # 02_59_analysis-purrr-split-map2.R
pdfs <- 
  paste0(names(gg_sales_split), ".pdf") |>
  fs::path_temp()
purrr::map2(pdfs, gg_sales_split, ggsave, 
            device = cairo_pdf, width = 7, height = 7)
  # shell.exec(pdfs[1])

