prnt_5 <- function(df){
  dplyr::distinct(df) |> # 重複を除く
  print(n = 5)            # 最初の5行のみ
}
