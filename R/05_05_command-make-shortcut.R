  # RとRStudioのショートカットを作成してパスを通す
  # 05_05_command-make-shortcut.R
  # RStudioのショートカット作成
  # パスが異なるときは適宜変更
  # exe <- fs::path_home("Appdata/Local/Programs/RStudio/rstudio.exe")
exe <- 'C:/Progra~1/rstudio/rstudio.exe' # こちらの可能性あり
shortcut <- "rs"
wd <- fs::path_home("shortcut")
size <- 3
make_shortcut(exe, shortcut = shortcut, size = size, wd = wd)

  # Rのショートカット作成
  # パスが異なるときは適宜変更
exe <- fs::path(Sys.getenv("R_HOME"), "bin/x64/Rgui.exe")
shortcut <- "r"
 # --no-restore：環境を復元しない，--no-save：終了時に保存しない
arg <- "--no-restore --no-save --sdi --silent"
make_shortcut(exe, shortcut, arg = arg, size = size, wd = wd)

  # C:/Users/USERNAME/shortcut にパスを通す
new_path <- add_path(wd)

