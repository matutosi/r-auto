  # 列の縦方向への分割
  # 02_16_analysis-tidyr-separate-longer-delim.R
answer <- tidyr::separate_longer_delim(answer, apps, delim = ";")
head(answer, 3)

