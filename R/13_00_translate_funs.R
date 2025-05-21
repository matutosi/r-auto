  # 文に分割する関数
  # 13_12_translate-split-sentence-fun.R
split_sentence <- function(x){
  x <- 
    x |>
    stringr::str_replace_all("([。.] *)", "\\1EOS") |> # 区切り文字の挿入
    stringr::str_split("EOS") |>                       # 区切り文字で分割
    unlist()
  return(x[x != ""])                                   # ""(空文字列)を除去
}
