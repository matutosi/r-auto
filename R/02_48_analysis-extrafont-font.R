  # 利用可能なフォントの確認
  # 02_48_analysis-extrafont-font.R
extrafont::fonts()
extrafont::fonts() |>
  stringr::str_subset("Yu")

