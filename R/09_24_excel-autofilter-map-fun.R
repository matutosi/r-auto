  # 全シートに同じ関数を実行する関数
  # 09_24_excel-autofilter-map-fun.R
walk_wb <- function(wb, fun, ...){
  openxlsx::sheets(wb) |>       # シート名を取得
    purrr::walk(fun, wb = wb, ...) # fun(wb = wb, sheet = sheet)のように受け取る
}

