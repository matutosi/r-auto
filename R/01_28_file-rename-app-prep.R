  # 作業用のダミーファイルの生成
  # 01_28_file-rename-app-prep.R
paste0(letters[1:10], ".pdf") |>
  file_create()
shell.exec(path_wd()) # 作業ディレクトリを開く(Windowsのみ)

