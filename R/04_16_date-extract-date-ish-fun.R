  # 日付っぽい文字列を抽出する関数
  # 04_16_date-extract-date-ish-fun.R
extract_date_ish <- function(str, simplify = FALSE){
  pattern <- date_ish()
  res <-
    stringr::str_extract_all(str, pattern = pattern, simplify = simplify)
  if(length(res) == 1){
    res <- res[[1]]
  }
  return(res)
}

