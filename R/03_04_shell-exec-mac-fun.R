  # 関連付けファイルで開く関数
  # 03_04_shell-exec-mac-fun.R
#' @params path A string of for file name
#' @examples
#' shell_open("sample.txt")
shell_open <- function(path){
  cmd <- paste0("open ", path)
  system(cmd)
}

