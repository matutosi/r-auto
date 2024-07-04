  # 関連付けアプリで開く関数
  # 05_06_command-exec-mac-fun.R
shell.exec <- function(file){
  cmd <- paste0("open ", file)
  system(cmd)
}

