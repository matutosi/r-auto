  # パスワード付きのzipファイルを解凍する関数
  # 03_16_command-unzip-pass-fun.R
unzip_with_password <- function(zip, passwd = "", bin_path = ""){
  dir <- fs::path_dir(zip)
  unzip_dir <- fs::path_file(zip) |>
               fs::path_ext_remove()                 # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir) |> # 
               stringr::str_replace_all(" ", "_") |> # スペースを置換
               fs::dir_create()                      # ディレクトリ作成
  zip <- paste0('"', zip, '"')
  if(passwd == ""){
    passwd <- read.table("clipboard")[1,]            # クリップボードから
  }
  cmd <- paste0(bin_path, "7z x ", zip, " -p", passwd, " -o", unzip_dir)
  system(cmd)
  return(unzip_dir)
}

