  # 利用可能なフォントの確認
  # 02_52_analysis-extrafont-font.R
extrafont::fonts()
extrafont::fonts() |>
  stringr::str_subset("Yu")

