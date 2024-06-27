  # 利用可能なフォントの確認
  # 02_51_analysis-extrafont-font.R
extrafont::fonts()
extrafont::fonts() |>
  stringr::str_subset("Yu")

