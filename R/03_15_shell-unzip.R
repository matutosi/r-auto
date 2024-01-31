  # zipファイルの解凍
  # 03_15_shell-unzip.R
#' @params zip A string for full path of a zip file.
unzip_with_dir <- function(zip){
  dir <- fs::path_dir(zip)                    # ディレクトリ
  unzip_dir <- fs::path_file(zip)             # ファイル名
  unzip_dir <- fs::path_ext_remove(unzip_dir) # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir)       # 解凍先ディレクトリ
  fs::dir_create(unzip_dir)                   # ディレクトリ生成
  utils::unzip(zip, exdir = unzip_dir)        # 解凍
  return(unzip_dir)
}
dir_usr <- Sys.getenv("USERPROFILE")        # "c:/Users/USERNAME"
dsk <- fs::path(dir_usr, "Desktop")         # デスクトップのディレクトリ
zips <- fs::dir_ls(dsk, regexp = "\\.zip")  # zipファイル一覧
dirs <- purrr::map(zips, unzip_with_dir)    # 解凍
purrr::map(dirs, shell.exec)                # ディレクトリを開く

