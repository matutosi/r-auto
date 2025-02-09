  # 漏れ(欠落データ)の抽出
  # 02_13_analysis-dplyr-anti-join.R
lost <- dplyr::filter(answer, apps != "-") # apps == "-" を欠落させる
print(answer, n = 3) # もとのデータ
print(lost, n = 3)   # 欠落データ
dplyr::anti_join(answer, lost) |> print(n = 3) # lostで欠落したものを抽出

