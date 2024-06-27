  # 文字列を箇条書きに変換する関数
  # 10_09_powerpoint-str2ul-fun.R
str2ul <- function(str, sep = ";", symbol = "-"){
  if(length(str) == 1){ # 1つの文字列のとき
    str <- 
      str |>
      stringr::str_split_1(pattern = sep) |> # 区切り文字で分割
      stringr::str_subset("^.+$") # 空文字("")を除去
  }
  str_list <- stringr::str_remove(str, paste0("^", symbol, "*")) # 記号の除去
  level_list <- 
    str |>
    stringr::str_extract(paste0("^", symbol, "*")) |> # 記号の抽出
    stringr::str_count(symbol) # 記号の数(=箇条書きの水準)
  ul <- unordered_list(str_list = str_list,
                       level_list = level_list)
  return(ul)
}

