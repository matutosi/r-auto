  # 横長形式への変換
  # 02_11_analysis-tidyr-pivot-wider.R
head(answer, 5)
answer <- 
  tidyr::pivot_wider(answer, names_from = item, values_from = ans)
head(answer, 5)

