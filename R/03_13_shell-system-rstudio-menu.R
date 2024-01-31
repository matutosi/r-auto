  # 拡張子のないファイルをアプリを指定して起動
  # 03_13_shell-system-rstudio-menu.R
  # 半角スペースがあるので文字列として「"」を含める
  # シングルクオーテーション(')はダブルクオーテーション(")と区別するため
bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
  # bin <- '"d:/pf/hidemaru/hidemaru.exe"'
file <- fs::path(Sys.getenv("LOCALAPPDATA"), 
                 "RStudio/monitored/lists/project_mru")
cmd <- paste0(c(bin, file), collapse = " ")
res <- system(cmd, wait = FALSE)
res

