  # 文字列の検索
  # 05_12_string-filter-detect.R
mpg <- mpg[,1:5]   # 自動車の燃費データ(dplyrに含まれる)のうち5列だけ
dplyr::filter(mpg, str_detect(model, "pickup")) |> print(n = 3)
dplyr::filter(mpg, str_detect(model, "pickup", negate = TRUE)) |> print(n = 3)

