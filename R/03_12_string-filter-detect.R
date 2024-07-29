  # 文字列の検索
  # 03_12_string-filter-detect.R
  # library(tidyverse) # tidyverseを呼び出していないとき
mpg <- mpg[,1:5]   # 自動車の燃費データ(dplyrに含まれる)のうち5列だけ
dplyr::filter(mpg, # pickupとマッチするもの
  str_detect(model, "pickup")) |> print(n = 5)
dplyr::filter(mpg, # pickupとマッチしないもの
  str_detect(model, "pickup", negate = TRUE)) |> print(n = 5)

