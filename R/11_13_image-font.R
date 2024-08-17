  # 使用できるフォントの例
  # 11_13_image-font.R
fonts <- 
  magick_fonts()$family |>
  stringr::str_subset("Meiryo|Yu") |>
  unique() |>
  print()

