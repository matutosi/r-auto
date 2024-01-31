  # ディレクトリ内でのファイルのコピー
  # 01_24_fs-copy.R
copy_files <- stringr::str_c("copy_", files) # コピー後のファイル名
(file_copy(files, copy_files)) # 両端の()で結果を表示

