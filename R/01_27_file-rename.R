  # ファイル名の変更
  # 01_27_file-rename.R
(files <- dir_ls(regexp = "\\.txt$"))
(new_path <- c("foo.txt", "bar.txt", "baz.txt"))
(file_move(files, new_path))

