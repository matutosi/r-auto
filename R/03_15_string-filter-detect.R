  # 文字列の検索
  # 03_15_string-filter-detect.R
  # library(tidyverse) # tidyverseを呼び出していないとき
(mpg <- mpg[,1:5]) # 自動車の燃費データ(dplyrに含まれる)のうち5列だけ
dplyr::filter(mpg, str_detect(model, "pickup")) |> prnt_5()  # pickupを含む
dplyr::filter(mpg, !str_detect(model, "pickup")) |> prnt_5() # !で否定

