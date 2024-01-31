  # 作業用のダミーファイルの生成
  # 01_29_fs-rename-app-prep.R
paste0(letters[1:10], ".pdf") |>
  file_create()
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

