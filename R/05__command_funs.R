  # パスを通す関数(Windows用)
  # 05_02_command-add-path-fun.R
add_path <- function(new_path){
  path <- get_user_path()
  path <- paste0(normalizePath(new_path), ";", path)
  cmd <- paste0("setx path ", path) # パス設定のdosコマンド
  res <- system(cmd, intern = TRUE) # コマンド実行
  message(iconv(res, "sjis", "utf8")) # 文字化け対策
  return(path)
}
get_user_path <- function(){
   # レジストリエディタでパスを取得するコマンド
  cmd <- 'reg query "HKEY_CURRENT_USER\\Environment" /v "path"'
  path <- 
    system(cmd, intern = TRUE)[3] |> # コマンド実行
    stringr::str_remove(" *path *REG_[A-z]* *") |> # 必要部分の取り出し
    double_quote()
  return(path)
}
double_quote <- function(x){
  paste0('"', x, '"') # 文字列をダブルクオートで囲む
}
  # 関連付けアプリで開く関数
  # 05_06_command-exec-mac-fun.R
shell.exec <- function(file){
  cmd <- paste0("open ", file)
  system(cmd)
}
  # 秀丸エディタでファイルを開く関数
  # 05_12_command-hidemaru-fun.R
open_with_hidemaru <- function(file){
  bin <- '"c:/Program Files/hidemaru/hidemaru.exe"'
  cmd <- paste0(c(bin, file), collapse = " ")
  res <- system(cmd, wait = FALSE)
  return(ures)
}
  # zipファイルを解凍する関数
  # 05_15_command-unzip-fun.R
unzip_with_dir <- function(zip){
  dir <- fs::path_dir(zip)                    # ディレクトリ
  unzip_dir <- fs::path_file(zip)             # ファイル名
  unzip_dir <- fs::path_ext_remove(unzip_dir) # 拡張子除去
  unzip_dir <- fs::path(dir, unzip_dir)       # 解凍先ディレクトリ
  fs::dir_create(unzip_dir)                   # ディレクトリ生成
  utils::unzip(zip, exdir = unzip_dir)        # 解凍
  return(unzip_dir)
}
  # パスワード付きのzipファイルを解凍する関数
  # 05_17_command-unzip-pass-fun.R
unzip_with_password <- function(zip, passwd = "", bin_path = ""){
  dir <- fs::path_dir(zip)
  unzip_dir <- 
    fs::path_file(zip) |>
    fs::path_ext_remove()                 # 拡張子除去
  unzip_dir <- 
    fs::path(dir, unzip_dir) |> # 
    stringr::str_replace_all(" ", "_") |> # スペースを置換
    fs::dir_create()                      # ディレクトリ作成
  zip <- paste0('"', zip, '"')
  if(passwd == ""){
    passwd <- read.table("clipboard")[1,] # クリップボードから
  }
  cmd <- paste0(bin_path, "7z x ", zip, " -p", passwd, " -o", unzip_dir)
  system(cmd)
  return(unzip_dir)
}
