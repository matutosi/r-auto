  # リストに分割する関数の定義
  # 02_55_analysis-purrr-split-by-fun.R
split_by <- function(df, group){
  split(df, df[[group]])
}

