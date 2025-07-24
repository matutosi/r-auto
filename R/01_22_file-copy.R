  # ディレクトリ内でのファイルのコピー
  # 01_22_file-copy.R
copy_files <- stringr::str_c("copy_", files) # コピー後のファイル名
(file_copy(files, copy_files)) # ()で囲むことで結果を表示

