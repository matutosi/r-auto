  # zipファイルの解凍
  # 05_16_command-unzip.R
dir_usr <- Sys.getenv("USERPROFILE")       # "c:/Users/USERNAME"
dsk <- fs::path(dir_usr, "Desktop")        # デスクトップのディレクトリ
zips <- fs::dir_ls(dsk, regexp = "\\.zip") # zipファイル一覧
dirs <- purrr::map(zips, unzip_with_dir)   # 解凍
purrr::map(dirs, shell.exec)               # ディレクトリを開く

