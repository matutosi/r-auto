  # 漏れ(欠落データ)の抽出
  # 02_13_analysis-dplyr-anti-join.R
lost <- dplyr::filter(answer_joined, apps != "-") # apps == "-" を欠落させる
print(answer_joined, n = 3) # もとのデータ
print(lost, n = 3)   # 欠落データ
dplyr::anti_join(answer_joined, lost) |> print(n = 3) # lostで欠落したものを抽出

