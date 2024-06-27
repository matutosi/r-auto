  # 漏れ(欠落データ)の抽出
  # 02_18_analysis-dplyr-anti-join.R
lost <- dplyr::filter(answer, apps != "-") # apps == "-" を欠落させる
length(answer)
length(lost)
print(lost, n = 5)
dplyr::anti_join(attribute, lost) # attributeにあって，lostにないもの

