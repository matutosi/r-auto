  # ファイル名の変更
  # 01_28_fs-rename.R
(files <- dir_ls(regexp = "\\.txt$"))
(new_path <- c("foo.txt", "bar.txt", "baz.txt"))
new_path
(file_move(files, new_path))

