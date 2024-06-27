  # fsパッケージの関数一覧
  # 01_03_file-list.R
  # install.packages("tidyverse") # tidyverseをインストールしていないとき
  # library(tidyverse) # tidyverseを呼び出していないとき
ls("package:fs") |> stringr::str_subset("^dir")
ls("package:fs") |> stringr::str_subset("^file")
ls("package:fs") |> stringr::str_subset("^path")

