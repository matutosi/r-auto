  # 全シートに同じ関数を実行する関数
  # 09_24_excel-autofilter-map-fun.R
map_wb <- function(wb, fun, ...){
  res <- 
    openxlsx::sheets(wb) |>       # シート名を取得
    purrr::map(fun, wb = wb, ...) # fun(wb = wb, sheet = sheet)のように受け取る
  return(invisible(res)) # 非表示で返す
}

