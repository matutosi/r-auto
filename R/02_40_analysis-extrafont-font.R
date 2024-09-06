  # 利用可能なフォントの確認
  # 02_40_analysis-extrafont-font.R
extrafont::fonts()
extrafont::fonts() |>
  stringr::str_subset("Yu")

