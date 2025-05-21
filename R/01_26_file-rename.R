  # ファイル名の変更
  # 01_26_file-rename.R
(files <- dir_ls(regexp = "\\.txt$"))            # 名前を変えたいファイル
(new_path <- c("foo.txt", "bar.txt", "baz.txt")) # 変更後のファイル名
(file_move(files, new_path))

