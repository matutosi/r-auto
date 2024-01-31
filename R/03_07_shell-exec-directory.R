  # ホームディレクトリを開く
  # 03_07_shell-exec-directory.R
home <- fs::path_home()
shell.exec(home) # Windows
  # shell_open(home) # Mac / Ubuntu

