  # ```{r make_shortcut, eval = FALSE, subject = 'Sys.getenv()', caption ='RとRStudioのショートカットを作成してパスを通す'}
  # 03_03_make_shortcut.R
  # RStudioのショートカット作成
  # パスが異なるときは適宜変更
exe <- fs::path(Sys.getenv("LOCALAPPDATA"), "Programs/RStudio/rstudio.exe")
shortcut <- "rs"
wd <- Sys.getenv("R_USER")
size = 3
res <- automater::make_shortcut(exe, shortcut = shortcut, size = size, wd = wd)

  # Rのショートカット作成
  # パスが異なるときは適宜変更
exe <- fs::path(Sys.getenv("R_HOME"), "bin/x64/Rgui.exe")
shortcut <- "r"
 # --no-restore：環境を復元しない，--no-save：終了時に保存しない
 # --sdi：SDIで起動，--silent：起動時メッセージを出さない
arg <- "--no-restore --no-save --sdi --silent"
wd <- Sys.getenv("R_USER")
size = 3
res <- automater::make_shortcut(exe, shortcut = shortcut, arg = arg, size = size, wd = wd)
  # C:/Windows/USERNAME/shortcut にパスを通す
new_path <- 
  fs::path_dir(res$shortcut) |>
  automater::add_path()

