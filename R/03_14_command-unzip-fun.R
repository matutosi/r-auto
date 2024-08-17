  # zipファイルを解凍する関数
  # 03_14_command-unzip-fun.R
unzip_with_dir <- function(zip){
  dir <- fs::path_dir(zip)                    # ディレクトリ
  unzip_dir <- fs::path_file(zip)             # ファイル名
  unzip_dir <- fs::path_ext_remove(unzip_dir) # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir)       # 解凍先ディレクトリ
  fs::dir_create(unzip_dir)                   # ディレクトリ生成
  utils::unzip(zip, exdir = unzip_dir)        # 解凍
  return(unzip_dir)
}

