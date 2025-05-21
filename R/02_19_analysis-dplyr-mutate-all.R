  # 指定列の変換
  # 02_19_analysis-dplyr-mutate-all.R
answer_mutated <- # data/answer_mutated.csv
  dplyr::mutate_at(answer_joined, c("id", "years", "satisfy"), as.numeric) |> 
  print(n = 3)

