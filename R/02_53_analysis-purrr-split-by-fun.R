  # リストに分割する関数の定義
  # 02_53_analysis-purrr-split-by-fun.R
split_by <- function(df, group){
  split(df, df[[group]])
}

