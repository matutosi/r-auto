  # 秀丸エディタでファイルを開く関数
  # 03_12_command-hidemaru-fun.R
open_with_hidemaru <- function(file){
  bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
  cmd <- paste0(c(bin, file), collapse = " ")
  res <- system(cmd, wait = FALSE)
  return(ures)
}

