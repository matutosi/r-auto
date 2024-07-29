  # 繰り返し処理のエラー対応
  # 02_59_analysis-purrr-safely.R
purrr::map(1:3, error_if_two)  # そのままのとき
error_if_two_possibly <- possibly(error_if_two, otherwise = 0) # エラー時は0
purrr::map_dbl(1:3, error_if_two_possibly)

