  # 個数を数えるショートカット(疑似コード)
  # 02_30_analysis-dplyr-tally.R
dplyr::group_by(df, 列名) |> 
  dplyr::tally()
dplyr::count(df, 列名)

