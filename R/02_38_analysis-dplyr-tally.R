  # 個数を数えるショートカット(擬似コード)
  # 02_38_analysis-dplyr-tally.R
dplyr::group_by(df, 列名) |> 
  dplyr::tally()
dplyr::count(df, 列名)

