  # 拡張子のみとファイル名のみの抽出
  # 01_21_fs-ext.R
path_ext(md_files)
path_ext_remove(md_files)

  # 下位ディレクトリも対象とするとき
all_files <- dir_ls(type = "file", recurse = TRUE)
path_ext(all_files)
path_ext_remove(all_files)

