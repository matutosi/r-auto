  # purrr::reduce()をデータフレームに適用する糖衣関数
  # 10_15_powerpoint-preduce-fun.R
preduce <- function(.l, .f, ..., .init, .dir = c("forward", "backward")){
  .dir <- match.arg(.dir)
  purrr::reduce(
    purrr::transpose(.l), 
    \(x, y){ rlang::exec(.f, x, !!!y, ...) }, 
    .init = .init, .dir = .dir)
}

