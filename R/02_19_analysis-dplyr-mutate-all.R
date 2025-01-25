  # 指定列の変換
  # 02_19_analysis-dplyr-mutate-all.R
answer <- dplyr::mutate_at(answer, c("id", "years", "satisfy"), as.numeric) |> 
  print(n = 3)

