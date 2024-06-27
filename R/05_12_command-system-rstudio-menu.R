  # 拡張子のないファイルをアプリを指定して起動
  # 05_12_command-system-rstudio-menu.R
  # 半角スペースがあるので文字列として「"」を含める
  # bin <- '"c:/Program..."' のシングルクオーテーション(')は
  #   ダブルクオーテーション(")と区別するため
bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
file <- fs::path(Sys.getenv("LOCALAPPDATA"), 
                 "RStudio/monitored/lists/project_mru")
cmd <- paste0(c(bin, file), collapse = " ")
system(cmd, wait = FALSE)

