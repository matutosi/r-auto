  # 漏れ(欠落データ)の抽出
  # 02_19_analysis-dplyr-anti-join.R
lost <- dplyr::filter(answer, apps != "-") # apps == "-" を欠落させる
print(answer, n = 3)
print(lost, n = 3)
dplyr::anti_join(answer, lost) |> print(n = 5) # lostで欠落したもの

