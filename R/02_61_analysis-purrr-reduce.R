  # 順次処理の関数
  # 02_61_analysis-purrr-reduce.R
paste_if_not_exist <- function(x, y){
  pattern <- paste0("(^|;)+", y, "(;|$)+")
  if(stringr::str_detect(x, pattern)){
    x
  }else{
    paste0(x, ";", y)
  }
}
answer |> 
  dplyr::summarise(apps = reduce(apps, paste_if_not_exist), 
                   .by = c(area, satisfy))

