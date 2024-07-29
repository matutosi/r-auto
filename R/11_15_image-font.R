  # 使用できるフォントの例
  # 11_15_image-font.R
  # install.packages("magick", repos = "https://ropensci.r-universe.dev")
fonts <- 
  magick_fonts()$family |>
  stringr::str_subset("Meiryo|Yu") |>
  unique() |>
  print()

