  # 単純集計
  # 02_35_analysis-dplyr-straight-summary.R
dplyr::count(answer, area)  |> print(n = 3)  # 単数回答・単純集計
count_multi(answer, "apps") |> print(n = 3)  # 複数回答・単純集計

