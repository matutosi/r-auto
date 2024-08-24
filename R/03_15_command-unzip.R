  # zipファイルの解凍
  # 03_15_command-unzip.R
dsk <- fs::path_home("Desktop")        # デスクトップのディレクトリ
zips <- fs::dir_ls(dsk, regexp = "\\.zip") # zipファイル一覧
dirs <- purrr::map(zips, unzip_with_dir)   # 解凍
purrr::map(dirs, shell.exec)               # ディレクトリを開く

