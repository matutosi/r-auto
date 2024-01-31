  # データフレームの表示を短縮する関数
  # 02_10_stringr-filter-fun.R
  # 表示を短縮するため
prnt_5 <- function(df){
  dplyr::distinct(df) |> # 重複を除く
  print(n = 5)            # 最初の5行のみ
}

