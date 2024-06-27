  # 個数を数えるショートカット
  # 02_35_analysis-dplyr-tally.R
dplyr::group_by(answer, area) |> 
  dplyr::tally() |> head(3)
dplyr::count(answer, area) |> head(3)
dplyr::count(sales, shop, wt = count) |> head(3)

