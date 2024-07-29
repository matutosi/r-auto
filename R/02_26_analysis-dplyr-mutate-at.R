  # 指定列の追加
  # 02_26_analysis-dplyr-mutate-at.R
answer <- dplyr::mutate_at(answer, c("id", "period", "satisfy"), as.numeric)

