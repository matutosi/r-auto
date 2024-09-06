  # 横長形式への変換
  # 02_09_analysis-tidyr-pivot-wider.R
head(answer, 3)
answer <- 
  tidyr::pivot_wider(answer, names_from = item, values_from = ans)
head(answer, 3)

