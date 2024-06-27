  # 繰り返し処理のエラー対応
  # 02_59_analysis-purrr-safely.R
error_if_two <- function(x){ # 0のときにエラーになる関数
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}
purrr::map(1:3, error_if_two)  # そのままのとき
error_if_two_safely <- safely(error_if_two) # エラーでも継続
purrr::map(1:3, error_if_two_safely) 
error_if_two_possibly <- possibly(error_if_two, otherwise = 0) # エラー時は0
purrr::map_dbl(1:3, error_if_two_possibly)

