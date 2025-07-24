  # 拡張子のみとファイル名のみの抽出
  # 01_19_file-ext.R
path_ext(md_files)
path_ext_remove(md_files)

  # サブディレクトリも対象とするとき
all_files <- dir_ls(type = "file", recurse = TRUE)
path_ext(all_files)
path_ext_remove(all_files)

