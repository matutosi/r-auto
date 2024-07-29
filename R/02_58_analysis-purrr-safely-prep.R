  # 2のときにエラーになる関数
  # 02_58_analysis-purrr-safely-prep.R
error_if_two <- function(x){
  if(x == 2){
    stop("エラーです")
  }else{
    return(x)
  }
}

