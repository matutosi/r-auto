  # 拡張子のないファイルをアプリを指定して起動
  # 03_11_command-system-rstudio-menu.R
bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
file <- fs::path(Sys.getenv("LOCALAPPDATA"), 
                 "RStudio/monitored/lists/project_mru")
cmd <- paste0(c(bin, file), collapse = " ")
system(cmd, wait = FALSE)

