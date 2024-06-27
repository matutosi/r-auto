  # 列の縦方向への分割
  # 02_15_analysis-tidyr-separate-rows.R
answer <- tidyr::separate_rows(answer, apps, sep = ";")
head(answer, 5)

