  # 横長形式への変換
  # 02_09_analysis-tidyr-pivot-wider.R
head(answer, 3)
answer_wide <- # data/answer_wide.csv
  tidyr::pivot_wider(answer, names_from = item, values_from = ans)
head(answer_wide, 3)

