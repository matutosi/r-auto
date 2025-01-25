  # 2のときにエラーになる関数
  # 02_49_analysis-purrr-possibly-prep.R
error_if_two <- function(x){
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}

