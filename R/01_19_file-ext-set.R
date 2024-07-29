  # 拡張子の設定
  # 01_19_file-ext-set.R
md_files <- dir_ls(type = "file", regexp = "\\.md$")
md_files
txt_file <- path_ext_set(md_files, "txt")
txt_file

