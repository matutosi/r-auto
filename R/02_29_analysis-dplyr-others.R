  # 列の順序変更と列名の変更
  # 02_29_analysis-dplyr-others.R
dplyr::relocate(answer_mutated, apps)      # 出力は省略
dplyr::rename(answer_mutated, ans_id = id) # 出力は省略

